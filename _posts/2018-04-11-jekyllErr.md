---
title: Jekyll Err
author: Shwin
layout: post
tag: Jekyll
---

### jekyll启动时出现的奇怪错误

# > `jekyll serve`
> WARN: Unresolved specs during Gem::Specification.reset:  
      rb-fsevent (>= 0.9.4, ~> 0.9)  
      ffi (< 2, >= 0.5.0)  
WARN: Clearing out unresolved specs.  
Please report a bug if this causes problems.  
/Library/Ruby/Gems/2.3.0/gems/bundler-1.16.1/lib/bundler.rb:508:in \`rescue in eval_gemspec':  (Bundler::Dsl::DSLError)  
[!] There was an error parsing \`Gemfile\`:  
[!] There was an error while loading \`jekyll-theme-prologue.gemspec\`: invalid byte sequence in US-ASCII. Bundler cannot continue.  

# > `bundle exec jekyll serve`
> [!] There was an error parsing `Gemfile`:  
[!] There was an error while loading `jekyll-theme-prologue.gemspec`: invalid byte sequence in US-ASCII. Bundler cannot continue.

# 原因
没有设置`LC_CTYPE`  
设置为Mac默认的`UTF-8`就ok了