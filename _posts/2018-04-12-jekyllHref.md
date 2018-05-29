---
title: Jekyll href
author: Shwin
layout: post
tag: Jekyll
---

### Gallery中图片链接到post

# Gallery中图片链接到post

之前使用的是html格式，需要写绝对路径，包括category

```
<a href="/blog/research/2015/08/28/NuclearRing.html" class="image fit"><img src="https://ws3.sinaimg.cn/large/006tNc79ly1fpn7g533svg30bt0btb2b.gif" alt="棒旋星系的核球和核环" /></a>
```

现在用jekyll的格式，不需要指定category  
[jekyll: linking-to-posts](https://jekyllrb.com/docs/templates/#linking-to-posts)

```
<a href={{ site.baseurl }}{% post_url 2018-02-11-HousePrice %} class="image fit"><img src="https://ws4.sinaimg.cn/large/006tNc79ly1fpn3uzy84jj31kw19itbk.jpg" alt="House price prediction" /></a>
```