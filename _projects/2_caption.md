---
layout: page
title: 読みやすい字幕を生成するシステムの開発
description: 
img: assets/img/transcription.png
importance: 2
category: work
related_publications: true
---

講演等の場で，高齢者や聴覚障害者の方のために字幕を提示する試みは多くなされています．
例えば，PowerPoint などのプレゼンテーションソフトウェアでも，音声認識の結果を字幕として提示する機能が備わっています．

しかし，自動生成された字幕は，字幕として冗長な部分が含まれる，読点や改行が挿入されていない，一般的な字幕提示のガイドラインに従っていない等の理由から，**必ずしも読みやすいものとは言えません**．

本研究では，上記の問題点を自動的に解決し，**読みやすい字幕を提示**することを目的としたシステムの開発を行います．

これまでに主に講演テキストの改行，読点挿入手法の開発{% cite fang_paclic2023 ohno_ieej2013 murata_emnlp2010 murata_ieice2009 %}を実施してきました．

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/transcription.png" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
</div>

また，「[音声認識ちゃん](https://www.sayonari.com/trans_asr/index_asr.html)」をベースに，ブラウザで読点・改行が挿入された字幕を提示するシステム，視線を検出しその視線座標上に字幕テキストを表示するシステムも開発中です．

<div class="repositories d-flex flex-wrap flex-md-row flex-column justify-content-between align-items-center">
  {% include repository/repo.liquid repository='MnacsM/caption_asr' %}
</div>

![demo](https://i.gyazo.com/b0afdba88aa5b6d16147975434af9f10.gif)
