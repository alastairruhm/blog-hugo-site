+++
title = "[翻译] 如何组织Go代码"
date = "2016-11-03"
tags = ["golang"]
+++

[toc]

# 如何组织Go代码

最近正在使用 `golang` 编写一个 `command line application`，感觉在语法上已经没有太多的问题，但是工程组织方面却经常处于迷茫的状态，项目扩展性很差。经过一番搜索，找到了这个 talk，原文见 https://talks.golang.org/2014/organizeio.slide#1。

## 包

### Go 程序都是由包构成

所有的 go 的源代码都是一个包的一部分，每一个源码文件在文件开头都有一个 `package` 语句，程序执行则是从 `main` 包开始的。

```golang
package main

import "fmt"

func main() {
    fmt.Println("Hello, world!")
}
```

对于一个非常简单的 `Go` 程序，只需要一个 `main` 包即可。

上面的 `hello world` 应用程序导入了`fmt`包，而函数`Println`在包`fmt`中定义。

### 示例包：fmt

```golang
// Package fmt implements formatted I/O.
package fmt

// Println formats using the default formats for its
// operands and writes to standard output.
func Println(a ...interface{}) (n int, err error) {
    ...
}

func newPrinter() *pp {
    ...
}
```

`Println` 函数是可被导出的。（可被导出的函数）首字母大写，意味着它可以被其他包访问。`newPrinter`函数是不可导出的，首字母小写，它只能在 `fmt`包内访问。

### 包的大小

包可大可小，甚至可能由多个源码文件组成，这些文件需要在同一个目录内。

Go 源码 net/http 包导出 100 个命名（共 18 个文件），而 errors 包只导出 1 个名字（只有 1 文件）。

### 包命名规范

包名要简短和有意义。 `_` 下划线会使包名变长，不要使用。

    * io/ioutil not io/util
    * suffixarray not suffix_array

不要太过于概括，比如 `util` 意义就很模糊

包名是类型和方法的一部分，比如：

```
buf := new(bytes.Buffer)
```

这个例子中就不需要取名为 `bytes.BytesBuffer`，过于冗余


### 测试包

测试文件和源码文件所处的目录应该同级，测试文件名均已 `_test.go` 结尾，如下例：

```golang
package fmt

import "testing"

var fmtTests = []fmtTest{
    {"%d", 12345, "12345"},
    {"%v", 12345, "12345"},
    {"%t", true, "true"},
}

func TestSprintf(t *testing.T) {
    for _, tt := range fmtTests {
        if s := Sprintf(tt.fmt, tt.val); s != tt.out {
            t.Errorf("...")
        }
    }
}
```

## 代码组织

### 工作目录

Go 相关工具可以很容易的区分出工作空间，构建时候不需要依赖 Makefile 等类似文件 ，按照目录划分好就可以工作。例如

```
$GOPATH/
    src/
        github.com/user/repo/
            mypkg/
                mysrc1.go
                mysrc2.go
            cmd/mycmd/
                main.go
    bin/
        mycmd
```

### 创建工作目录

```
mkdir /tmp/gows
GOPATH=/tmp/gows
```

$GOPATH 环境变量前面以及提到，后续的安装和构建包都依赖这个环境变量

```
$ go get github.com/dsymonds/fixhub/cmd/fixhub
```

`go get` 命令则会远程仓库下载源码到自己的工作目录内（需要相关的版本工具，比如：git）

`go install` 命令则可以编译和分发文件到 $GOPATH/bin/fixhub 位置。

现在这个工作目录如下：

```
$GOPATH/
    bin/fixhub                              # installed binary
    pkg/darwin_amd64/                       # compiled archives
        code.google.com/p/goauth2/oauth.a
        github.com/...
    src/                                    # source repositories
        code.google.com/p/goauth2/
            .hg
            oauth                           # used by package go-github
            ...
        github.com/
            golang/lint/...                 # used by package fixhub
                .git
            google/go-github/...            # used by package fixhub
                .git
            dsymonds/fixhub/
                .git
                client.go
                cmd/fixhub/fixhub.go        # package main
```

### 为什么预先定义目录结构

通过目录结构来区分，可以免去配置的麻烦，不像其他语言会依赖 Makefile 或 build.xml 文件。

减少配置的时间，可以更多的时间去码字，另外大部分用户目录结构都类似，这样也更有利于去分享代码。

### Go 工具箱


```
$ go help
Go is a tool for managing Go source code.

Usage:

go command [arguments]

The commands are:

```

常用的功能参数如：

```
build       compile packages and dependencies
get         download and install packages and dependencies
install     compile and install packages and dependencies
test        test packages
```

还有一些其他有用的功能参数，比如：`vet` 和 `fmt`。

## 依赖管理

默认情况下 `go get` 都会去下载最新的代码然后构建，除非被中断。

在开发环境下这个没什么影响，但肯定不适用于生产环境。

### 版本控制

两种方式：

* vendoring
* gopkg.in

## 命名规范

程序其实就是一堆名字的构成。

简单来说，长的名字浪费空间，而且在可读性方面很重要，好的名字一眼就能看意图。

### 命名风格

使用驼峰 camelCase，而不是下划线 _underscores 连接。
局部变量尽量短，短，短，1-2 个字符的情况很常见。
包的名字一般来说，都是小写字母。
全局变量应该使用一个更长更有意义的名字。

不建议这样：

* `bytes.Buffer`，不要 `bytes.ByteBuffer`
* `zip.Reader`，不要 `zip.ZipReader`
* `errors.New`，不要 `errors.NewError`
* `r` 不要用在 `bytesReader`
* `i` 不要用在 `loopIterator`

### 文档

文档位置在模块或者导出的名字前面：

```
// Join concatenates the elements of elem to create a single string.
// The separator string sep is placed between elements in the resulting string.
func Join(elem []string, sep string) string {
```

通过 godoc 在 web 查看该函数时候，文档位置位于函数原型下方（图略）。

### 文档书写

使用英语书写文档句子和段落

```
// Join concatenates…         good
// This function…             bad
```

包文档位于模块最上面：

```
// Package fmt…
	package fmt
```





