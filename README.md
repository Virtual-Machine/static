# Static

Static is a hard fork of [Kamber](http://github.com/f/kamber), a crystal blogging server based on [Kemal](http://github.com/sdogruyol/kemal). While Kamber was a static blog server that did not generate assets, Static generates the static assets on startup. This allows it to be used as a development server and to compile the assets to be uploaded to production servers. Static also resolves many dependancy issues and API deprecations present in Kamber.


> Kamber was not a static blog generator, Static is!


## Features

- Supports many post types:
  - **Markdown** Posts
  - GitHub **Gist**
  - **Tweet** Embeds
  - **Video** Embeds
  - Disqus Comments

## Getting Started

### 1. Install Crystal and Kamber
```
brew install crystal-lang
git clone https://github.com/virtual-machine/static myblog
cd myblog
shards install
```

### 2. Add Contents

- Edit `config.yml` and set your overall configuration.
- Edit `posts/posts.yml` file and add some content.

### 3. Build and Run
```
crystal build --release src/static.cr
./static
```

To run in production, add `-e production` flag.

```
./kamber -e production
```

## Post Types

`posts/posts.yml` has multiple YAML documents, each represents a blog item (aka post type).

### Post (Markdown)

```yml
type: post
title: Example Post
abstract: Lorem ipsum dolor sit amet, consectetur adipisicing elit
file: posts/example-post.md
disqus: true
```

### Link

```yml
type: link
title: Example Link
url: "http://crystal-lang.org"
```

### Video

Kamber supports **Youtube** and **Vimeo** videos. The main pattern of `video` is
`[video provider]/[video id]`

```yml
type: video
title: Example Video
abstract:
video: youtube/YE3GkCB3t_0
```

If you will use **Vimeo**, change `video` key to

```yml
video: vimeo/147842467
```

### Tweet

This type embeds Tweets to the index. The pattern is `[username]/[tweet id]`

```yml
type: tweet
title: Example Tweet
tweet: fkadev/673506301415194625
```

### Gist

This type embeds GitHub Gists to the index. The pattern is `[username]/[gist id]`

```yml
type: gist
title: Example Gist
gist: f/c12af6b9e7d53bd9224d
```


## Contributors

- [f](https://github.com/f) Fatih Kadir Akın - original designer of Kamber
- [f](https://github.com/virtual-machine) Virtual-Machine
