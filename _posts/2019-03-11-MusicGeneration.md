---
title: Generate Music with LSTM Networks
author: Shwin
layout: post
category: Project
---

## CS253 PA4
# Task

Generate music automatically

# Data

A compressed text file including 1,124 music sheets in ABC format

# Model

Naive teacher-forcing LSTM

# Example result
* **Given**: Meter - 3/4 &nbsp;  Key - D major &nbsp; Title - The Badeatle Polka

* **Output**:
<img src="https://ws1.sinaimg.cn/large/006tNc79ly1g1rps1vgdgj31um0n5mzj.jpg" style="display: block; width: 450px; margin: auto;" />

<div style="display: block; margin: auto">
<audio controls style="display: block; margin: auto">
    <source src="{{ 'assets/audios/best_model.mp3' | relative_url }}" type="audio/mpeg">
</audio>
</div>

# Interesting intepretation
Feed a music sheet into the model and see how a specific cell respond to each note. Hotter color corresponds to high activations. Clearly, this cell is responsible for differentiate the [tunes](http://trillian.mit.edu/~jc/music/abc/doc/ABCtut_Tunes.html) in the header.
<img src="https://ws2.sinaimg.cn/large/006tNc79ly1g1rj8ooy3bj30k00k03yv.jpg" style="display: block; width: 50%; margin: auto" />

# see our [report](https://drive.google.com/file/d/1S5T8wWJ72MoGmqfpt5Dl3PsLB0HTM3Qn/view?usp=sharing) for more

# see our [repo](https://github.com/shwinshaker/CS253-PA4) for source code
