---
layout: page
---

<div>
<div>
{% for tag in site.categories %}
<a href="#{{ tag[0] | slugify }}" class="post-tag">{{ tag[0] }}</a>
{% endfor %}
</div>
<hr/>
<div>
{% for tag in site.categories %}
<h2 id="{{ tag[0] | slugify }}">{{ tag[0] }}</h2>
    <ul>
    {% for post in tag[1] %}
    <a href="{{ post.url | absolute_url }}">
	<li>
	    {{ post.title }}
	    -
	    {{ post.date | date_to_string }}
	</li>
    </a>
    {% endfor %}
    </ul>
{% endfor %}
</div>
</div>
