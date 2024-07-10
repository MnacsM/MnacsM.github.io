---
layout: page
title: Research
permalink: /research/
description: 
nav: true
nav_order: 1
display_categories: [work, grant]
horizontal: True
---

<!-- pages/projects.md -->
<div class="projects">
{% if site.enable_project_categories and page.display_categories %}
  <!-- Display categorized projects -->
  {% for category in page.display_categories %}
  <a id="{{ category }}" href=".#{{ category }}">
    <h2 class="category">{{ category }}</h2>
  </a>
  {% assign categorized_projects = site.projects | where: "category", category %}
  {% assign sorted_projects = categorized_projects | sort: "importance" %}
  <!-- Generate cards for each project -->
  {% if page.horizontal %}
  <div class="container">
    <div class="row row-cols-1 row-cols-md-2">
    {% for project in sorted_projects %}
      {% include projects_horizontal.liquid %}
    {% endfor %}
    </div>
  </div>
  {% else %}
  <div class="row row-cols-1 row-cols-md-3">
    {% for project in sorted_projects %}
      {% include projects.liquid %}
    {% endfor %}
  </div>
  {% endif %}
  {% endfor %}

{% else %}

<!-- Display projects without categories -->

{% assign sorted_projects = site.projects | sort: "importance" %}

  <!-- Generate cards for each project -->

{% if page.horizontal %}

  <div class="container">
    <div class="row row-cols-1 row-cols-md-2">
    {% for project in sorted_projects %}
      {% include projects_horizontal.liquid %}
    {% endfor %}
    </div>
  </div>
  {% else %}
  <div class="row row-cols-1 row-cols-md-3">
    {% for project in sorted_projects %}
      {% include projects.liquid %}
    {% endfor %}
  </div>
  {% endif %}
{% endif %}
</div>

## 科研費

### 代表

1. [音声認識結果の要約と整形に基づく理解しやすい字幕の自動生成に関する研究, 基盤研究(C), 2022-2024](https://kaken.nii.ac.jp/ja/grant/KAKENHI-PROJECT-22K12122/){:target="_blank"}
1. [字幕の理解しやすさとの関係を考慮した音声データの漸進的な構造化に関する研究, 若手研究(B), 2016-2017](https://kaken.nii.ac.jp/ja/grant/KAKENHI-PROJECT-16K16119/){:target="_blank"}

### 分担

1. [リスナーとしてのスマートスピーカーが表出する共感的応答, 挑戦的研究(萌芽), 2018-2020](https://kaken.nii.ac.jp/ja/grant/KAKENHI-PROJECT-18K19811/){:target="_blank"}
1. [話し手の語る意欲を高めるパーソナルロボットの傾聴技術, 挑戦的萌芽研究, 2015-2018](https://kaken.nii.ac.jp/ja/grant/KAKENHI-PROJECT-15K12095/){:target="_blank"}
1. [通訳方略の体系化と文構造の逐次解析に基づく講演音声の同時通訳, 基盤研究(B), 2014–2019](https://kaken.nii.ac.jp/ja/grant/KAKENHI-PROJECT-26280082/){:target="_blank"}

