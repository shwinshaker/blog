---
title: Automatic Comment Generation for Python code
author: Shwin
layout: post
category: Project
---

## CS253 Final Project
# Task

Given a Python code snippet, generate its description as comment automatically

# Data

Question & Answer pairs on [Stackoverflow](https://stackoverflow.com), Python code only (Java code already experimented in [previous work](https://github.com/sriniiyer/codenn))

# Model

Sequence to Sequence model with LSTM modules and Attention
<img src="https://ws1.sinaimg.cn/large/006tNc79ly1g1r95tggt4j31180lk0tn.jpg" alt="architecture" style="display: block; width: 75%; margin: auto"/>

# Example results
* code snippet:  `django.template.loader.get_template(template_name)`
* target comment:  <I>check if a template exists in Django</I>
* generated comment:  <I>get a template in Django</I>

# To do
* address the imbalanced issue by force focusing on long code snippets, or using methods like curriculum learning
* carefully preprocess raw code and comments
* model visualization, especially attention part
* leverage attention more, try things like [transformer network](https://arxiv.org/abs/1706.03762)
* web application, try [flask](http://flask.pocoo.org)

# See our [report](https://drive.google.com/file/d/129sEH9lm0wZ24eVnyjFYv15iu0440WP2/view?usp=sharing) for more

# See our [repo](https://github.com/shwinshaker/Code2Comment) for source code
