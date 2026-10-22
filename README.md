# Masaki Murata’s website

個人サイト: <https://mnacsm.github.io/>

al-folio v1 の gem 構成で運用しています。公開用ソースは **main**、GitHub Pages が配信するビルド成果物は **gh-pages** です。

## ローカル確認

Ruby 3.4.7、Bundler 4.0.6、Node.js 22、Python 3、ImageMagick を使います。

```sh
bundle install
npm ci
bundle exec jekyll serve
```

<http://localhost:4000/> で確認できます。個人サイトなので `baseurl` は空のままです。

## 内容を編集する場所

- `_pages/`: プロフィール、研究、論文一覧、講義、卒論・修論一覧など。既存の `permalink` は維持してください。
- `_news/`: お知らせ。トップページの表示件数は `_pages/about.md` の `announcements`。
- `_projects/`: 研究紹介。
- `_bibliography/papers.bib`: 論文データ。日本語の論文は `language = {ja}` を指定すると著者名を「姓 名」で表示します。
- `_data/socials.yml`: SNS・メール・Google Scholar。
- `assets/img/`: プロフィール・研究用画像。
- `_config.yml`: 共通設定。論文検索は `bib_search`、サイト検索は `search_enabled`。

サンプルブログ・架空の人物・サンプルの研究紹介は含めません。

## al-folio の更新

2026-10-22 の移行では upstream `f2a2765c8a9413f6ec703fc02070fbe6becf1572` の v1 starter を基準にし、公開ソース `6c34f34e8043da6eae1ed6e9fa8fa4b818b443fb` の個人コンテンツを引き継ぎました。

テーマの実装は gem が所有するため、通常の更新では upstream 全体をそのままマージしません。`Gemfile` の対象 gem の固定バージョンをリリースノートに従って変更し、`bundle update GEM_NAME` で `Gemfile.lock` を更新します。プラグインを追加・削除するときは `_config.yml` の `plugins` も合わせます。starter の設定やワークフロー変更が必要な場合だけ、upstream の差分から選んで取り込みます。

```sh
git fetch upstream
# Gemfile の対象バージョンを編集した後:
bundle update al_folio_core
bundle exec al-folio upgrade audit
bundle exec al-folio upgrade overrides audit
bundle exec al-folio upgrade report
```

独自変更は次の2ファイルです。

- `_layouts/bib.liquid`: `al_folio_core` の論文レイアウトを基に、和英の著者名順と区切り、空のHTMLリンクを調整。
- `_includes/hook/bib.liquid`: 開催地・巻・号・ページの追加表示。公式の拡張フックを使用。

gem 更新時にレイアウトの変更が検出されたら、以下で差分を確認し、必要な変更を反映してから承認記録を更新します。未確認のまま `accept` しないでください。

```sh
bundle exec al-folio upgrade overrides diff _layouts/bib.liquid
bundle exec al-folio upgrade overrides accept _layouts/bib.liquid
```

`.al-folio-overrides.yml` もコミットします。互換Bootstrapモードは不要なので無効です。現行のコアCSSが研究カード等のレイアウトクラスを提供しています。

## 公開前の確認

```sh
npm run lint:prettier
JEKYLL_ENV=production bundle exec jekyll build
bundle exec ruby test/site_test.rb
npx playwright install chromium
npm run test:browser
bundle exec al-folio upgrade audit
bundle exec al-folio upgrade overrides audit
```

本文・画像・URLの維持に加えて、論文の件数／著者順／巻号ページ、内部リンク、サンプル除去、論文検索、ナビゲーション、スマートフォン幅、テーマ切替を検証します。

PRでは検証のみ実行し、`main` へのpush（または `main` からの手動実行）だけが `gh-pages` にデプロイします。生成済みのTailwind CSSを使うため、PurgeCSSは実行しません。

公式資料: [更新・移行手順](https://github.com/alshedivat/al-folio/blob/main/docs/INSTALL.md#upgrading-from-a-previous-version)、[機能とgemの対応](https://github.com/alshedivat/al-folio/blob/main/docs/BOUNDARIES.md)。`docs/` は移行時の公式資料です。starterデモ固有の設定（`/al-folio` など）をこの個人サイトには適用しないでください。
