<!--
description: "Configure a website."
date: 2021-05-07
-->

# Configuration

The website configuration is defined in a [YAML](https://en.wikipedia.org/wiki/YAML) file named `config.yml`, stored at the root:

```plaintext
<mywebsite>
└─ config.yml
```

_Example:_

```yaml
title: "Cecil"
baseline: "Your content driven static site generator."
baseurl: https://cecil.local/
description: "Cecil is a CLI application that merges plain text files (written in Markdown), images and Twig templates to generate a static website."
```

## Variables

### title

Main title of the site.

### baseline

Short description (~ 20 characters).

### baseurl

The base URL. Must end with a trailing slash (`/`).

_Example:_

```yaml
baseurl: http://localhost:8000/
```

### canonicalurl

If set to `true` the [`url()`](3-Templates.md#url) function will return the absolute URL (`false` by default).

### description

Site description (~ 250 characters).

### taxonomies

List of vocabularies, paired by plural and singular value.

_Example:_

```yaml
taxonomies:
  categories: category
  tags: tag
```

A vocabulary can be disabled with the special value `disabled`:

```yaml
taxonomies:
  tags: disabled
```

### menus

Each menu entry should have the following properties:

- `id`: unique identifier
- `name`: name used in templates
- `url`: relative or absolute URL
- `weight`: used to sort entries (lighter first)

A default `main` menu is created and contains the home page and sections entries.

_Example:_

```yaml
menus:
  footer:
    - id: author
      name: "The author"
      url: https://arnaudligny.fr
      weight: 99
```

#### Overrides entry properties

A page menu entry can be overridden: use the page index `id`.

_Example:_

```yaml
menus:
  main:
    - id: index
      name: "My amazing homepage!"
      weight: 1
```

#### Disable an entry

A menu entry can be disabled with `enabled: false`.

_Example:_

```yaml
menus:
  main:
    - id: about
      enabled: false
```

### pagination

Pagination is available for list pages (if _type_ is `homepage`, `section` or `term`):

- `max`: number of pages by paginated page (`5` by default)
- `path`: path to paginated page (`page` by default)

_Example:_

```yaml
pagination:
  max: 10
  path: "page"
```

#### Disable pagination

Pagination can be disabled with `enabled: false`.

_Example:_

```yaml
pagination:
  enabled: false
```

### date

Date format and timezone:

- `format`: [PHP date](https://php.net/date) format specifier
- `timezone`: date [timezone](https://php.net/timezones)

_Example:_

```yaml
date:
  format: "j F Y"
  timezone: "Europe/Paris"
```

### theme

The theme name (sub-directory of `themes`) or an array of themes.

_Example:_

```yaml
theme:
  - serviceworker
  - hyde
```

See [officials themes](https://github.com/Cecilapp?q=theme).

### metatags

[_Meta tags_](https://wikipedia.org/wiki/Meta_element) (for SEO) can be injected automatically in the `<head>` by including the [`partials/metatags.html.twig`](https://github.com/Cecilapp/Cecil/blob/master/resources/layouts/partials/metatags.html.twig) template.

*[SEO]: Search Engine Optimization

Cecil uses data from page's front matter to feed meta tags and from `config`:

```yaml
title: 'Site / Page title'
description: 'Site / Page description'
keywords: ['keyword1', 'keyword2'] # Use `tags` in case of a Page
author: 'Author name'
image: 'image.jpg'
social:
  twitter:
    site: '@username'
    creator: '@username'
  facebook:
    id: '123456789'
    firstname: 'Firstname'
    lastname: 'Lastname'
    username: 'username'
```

> Cecil search for a `favicon.png` file at root of `static` directory.

Default configuration:

```yaml
metatags:
  title:
    divider: ' &middot; ' # String between page title and site title
    only: false           # Display page title only
    pagination:
      shownumber: true    # Display page number in title
      label: 'Page %s'    # How to display page number
  robots: 'index,follow'  # Web crawlers directives
  articles: 'blog'        # Articles' section
  jsonld:
    enabled: true         # Inject JSON-LD meta tags
```

### googleanalytics

[Google Analytics](https://wikipedia.org/wiki/Google_Analytics) user identifier:

```yaml
googleanalytics: "UA-XXXXX"
```

Used by the built-in component template [`googleanalytics.html.twig`](https://github.com/Cecilapp/Cecil/blob/master/resources/layouts/partials/googleanalytics.js.twig).

### virtualpages

Virtual pages is the best way to create pages without content (front matter only).

It consists of a list of pages with a `path` and front matter variables.

_Example:_

```yaml
virtualpages:
  - path: code
    redirect: https://github.com/ArnaudLigny
```

### output

Defines where and how files are generated.

#### dir

Directory where rendered pages’ files are saved (`_site` by default).

#### formats

List of output formats.

- `name`: name of the format (ie: `html`)
- `mediatype`: [media type](https://en.m.wikipedia.org/wiki/Media_type) (formerly known as _MIME type_)
- `subpath`: sub path (ie: `/amp` in `path/amp/index.html`)
- `suffix`: file name (ie: `/index` in `path/index.html`)
- `extension`: file extension (ie: `html` in `path/index.html`)
- `exclude`: don’t apply this format to pages identified by specific variables, as array (ie: `[redirect]`)

#### pagetypeformats

Array of generated output formats for each page type (`homepage`, `page`, `section`, `vocabulary` and `term`).

_Example:_

```yaml
output:
  dir: _site
  formats:
    - name: html
      mediatype: "text/html"
      suffix: "/index"
      extension: "html"
    - name: rss
      mediatype: "application/rss+xml"
      suffix: "/rss"
      extension: "xml"
      exclude: [redirect, paginated]
  pagetypeformats:
    page: [html]
    homepage: [html, rss]
    section: [html, rss]
    vocabulary: [html]
    term: [html, rss]
```

### language

Main language (`en` by default).

### languages

List of available languages, used for [content](2-Content.md#multilingual) and [templates](3-Templates.md#localization) localization.

Required keys:

- `code`: language unique code
- `name`: human readable name of the language
- `locale`: [locale code](configuration/locale-codes.md) of the language

To localize configuration variables you must store them under a `config` key.

_Example:_

```yaml
title: 'Cecil in english'
languages:
  - code: en
    name: English
    locale: en_US
  - code: fr
    name: Français
    locale: fr_FR
    config:
      title: 'Cecil en français'
```

### paths

Define a custom [`path`](2-Content.md#variables) for all pages of a _Section_.

_Example:_

```yaml
paths:
  - section: Blog
    path: :section/:year/:month/:day/:slug
```

#### Available placeholders

- `:year`
- `:month`
- `:day`
- `:section`
- `:slug`

### debug

Enables the _debug mode_, used to display debug information like Twig dump, Twig profiler, SCSS sourcemap, etc.

_Example:_

```yaml
debug: true
```

There is 2 others way to enable the _debug mode_:

1. Run a command with the `-vvv` option
2. Set the `CECIL_DEBUG` environment variable to `true`

## Default values

The local website configuration file (`config.yml`) overrides the [default configuration](https://github.com/Cecilapp/Cecil/blob/master/config/default.php#L11).

### defaultpages

Default pages are pages created automatically by Cecil, from built-in templates:

- *404.html*
- *robots.txt*
- *sitemaps.xml*

The structure is almost identical of [`virtualpages`](#virtualpages), except the named key:

```yaml
defaultpages:
  index:
    path: ''
    title: 'Home'
    published: true
  404:
    path: '404'
    title: 'Page not found'
    layout: '404'
    uglyurl: true
    published: true
    exclude: true
  robots:
    path: robots
    title: 'Robots.txt'
    layout: 'robots'
    output: 'txt'
    published: true
    exclude: true
    multilingual: false
  sitemap:
    path: sitemap
    title: 'XML sitemap'
    layout: 'sitemap'
    output: 'xml'
    changefreq: 'monthly'
    priority: '0.5'
    published: true
    exclude: true
    multilingual: false
```

Each one can be:

1. disabled with `published: false`
2. excluded from list pages with `exclude: true`
3. not translated with `multilingual: false`

### content

Where content files are stored.

- `dir`: pages directory (`content` by default)
- `ext`: array of files extensions

> Supported format: Markdown and plain text files.

### frontmatter

Pages’ variables format.

- `format`: front matter format (`yaml` by default)

### body

Pages’ content format and converter’s options.

```yaml
body:
  format: md             # Page body format (only Markdown is supported)
  toc: [h2, h3]          # Headers used to build the table of contents
  images:                # How to handle images
    lazy:
      enabled: true      # Enable lazy loading (`true` by default)
    resize:
      enabled: false     # Enable image resizing by using the `width` extra attribute (`false` by default)
    responsive:
      enabled: false     # Enable responsive images (`false` by default)
      width:             # `srcset` range
        steps: 5           # Number of steps from `min` to `max`
        min: 320           # Minimum width
        max: 1280          # Maximum width
      sizes:
        default: '100vw' # Default sizes
```

See [Content > Page > Body](2-Content.md#body) documentation for more information.

### data

Where data files are stored.

- `dir`: data directory (`data` by default)
- `ext`: array of files extensions
- `load`: boolean (`true` by default)

> Supported format: YAML, JSON, XML and CSV.

### static

Where static files and assets (CSS, images, PDF, etc.) are stored and copied.

- `dir`: files directory (`static` by default)
- `target`: target directory (empty by default)
- `exclude`: list of excluded files (accepts globs, strings and regexes)
- `load`: boolean (`false` by default, used by [`site.static`](3-Templates.md#site-static))

_Example:_

```yaml
static:
  dir: docs
  target: docs
  exclude:
    - 'sass'
    - '*.scss'
    - '/\.bck$/'
  load: true
```

### layouts

Where templates files are stored.

- `dir`: layouts directory (`layouts` by default)

### themes

Where themes are stored.

- `dir`: themes directory (`themes` by default)

### assets

Assets handling options.

```yml
assets:
  fingerprint:
    enabled: true
  compile:
    enabled: true
    style: nested
    import: [sass, scss]
  minify:
    enabled: true
  target: assets
  images:
    quality: 90
```

- `fingerprint`: Adds the file fingerprint in the filename
- `compile`: Compiles a SCSS with the given
  - `style`: Output formatter’s name (see [documentation of scssphp](https://scssphp.github.io/scssphp/docs/#output-formatting))
  - `import`: Array of imported path
  - `sourcemap`: Enables sourcemap output (if [debug mode](#debug) is enabled)
  - `variables`: Array of preset variables (see [documentation of scssphp](https://scssphp.github.io/scssphp/docs/#preset-variables))
- `minify`: Compresses file content (Available for file with a `text/css` or `text/javascript` MIME Type)
- `target`: Target directory of remote and resized assets (`assets` by default)
- `images`: Options for images
  - `quality`: Image quality after resize (`90` by default)

### postprocess

Files optimizations (post process) options.

```yaml
postprocess:
  enabled: false
  html:
    ext: [html, htm]
  css:
    ext: [css]
  js:
    ext: [js]
  images:
    ext: [jpeg, jpg, png, gif, webp, svg]
```

Images compressor will use these binaries if they are present on your system:

- [JpegOptim](http://freecode.com/projects/jpegoptim)
- [Optipng](http://optipng.sourceforge.net/)
- [Pngquant 2](https://pngquant.org/)
- [SVGO](https://github.com/svg/svgo)
- [Gifsicle](http://www.lcdf.org/gifsicle/)
- [cwebp](https://developers.google.com/speed/webp/docs/precompiled)

### cache

Cache options.

- `dir`: cache directory (`.cache` by default)
- `enabled`: boolean (`false` by default)
- `templates`: Twig cache
  - `dir`: the subdirectory of `.cache` where templates cache is stored (default: `templates`)
  - `enabled`: `true` or `false` (default: `true`)
- `assets`: assets cache
  - `dir`: the subdirectory of remote assets cache

### generators

Generators priorities.

```yaml
generators:
  10: 'Cecil\Generator\DefaultPages'
  20: 'Cecil\Generator\VirtualPages'
  30: 'Cecil\Generator\ExternalBody'
  40: 'Cecil\Generator\Section'
  50: 'Cecil\Generator\Taxonomy'
  60: 'Cecil\Generator\Homepage'
  70: 'Cecil\Generator\Pagination'
  80: 'Cecil\Generator\Alias'
  90: 'Cecil\Generator\Redirect'
```

## Config file alternative

### Environment variables

Configuration can be defined through [environment variables](https://en.wikipedia.org/wiki/Environment_variable).

Name must be prefixed with `CECIL_` and the configuration key must be set in uppercase.

For example, the following command will set the website’s `baseurl`:

```bash
export CECIL_BASEURL="https://example.com/"
```