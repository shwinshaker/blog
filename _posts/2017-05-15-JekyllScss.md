---
title: Jekyll Scss
author: Shwin
layout: post
tags: Jekyll Css
---
<!-- <head>
<link rel="stylesheet" type="text/css" href="{{- 'assets/css/md.css' | relative_url -}}" />
</head> -->

### jekyll scss研究
<!-- <script src="https://gist.github.com/shwinshaker/f463f872bde469be021c2a55fc0399e4.js"></script>
 -->
# jekyll-theme-prologue.scss
作为自己blog的主题，有必要好好研究一下其具体配置，这里就从`jekyll-theme-prologue.scss`入手吧。  

首先，`jekyll-theme-prologue.scss`使用的是`scss`语法，和`css`略有不同，特性上要比`css`更方便一些，官方文档见这里[Sass(Scss) reference](http://sass-lang.com/documentation/file.SASS_REFERENCE.html#parent-selector)，其中给出了详细的`scss`和`css`的对照。

# 典型特性
* 多级继承
```
dl {
	dt {
		font-weight: 300;
		color: #666;
	}		
    dd {
		margin-left: 1em
	}
}
```
* `@import`函数
* `$`定义变量
* `&`：方便地引用parent，例如
```
a {
	text-decoration: none;
	color: inherit;
	border-bottom: dotted 1px rgba(128, 128, 128, 0.5);
	@include vendor('transition', ('color 0.35s ease-in-out', 'border-bottom-color 0.35s ease-in-out'));
	outline: 0;

	&:hover {
		color: #E27689;
		border-bottom-color: rgba(255, 255, 255, 0);
	}
}
```
* `>`：选择直接相连的child(这个css也有)

# 其他发现
* 在`gallery.html`中的`<a class="image fit">`的定义位于：
```
.image {
	&.fit {
		display: block;
		width: 100%;
	}
}
```

* `@include breakpoint(wide) {}`等属于**Responsive Design**，即对不同的设备、或拖动带来的显示尺寸的不同使用不同的样式。在`jekyll-theme-prologue.scss`的开头有对`wide` `normal` `narrow` `narrower` `mobile`做出尺寸的具体定义。尺寸表见[Media Queries for Standard Devices](https://css-tricks.com/snippets/css/media-queries-for-standard-devices/)。

