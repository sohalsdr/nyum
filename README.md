# nyum

*A simple Pandoc-powered static site generator for your recipe collection.*

<img src="assets/favicon.png" align="right" width="96">

This tool takes a **collection of Markdown-formatted recipes** and turns it into a **lightweight, responsive, searchable website** for your personal use as a reference while cooking, or for sharing with family and friends. It's *not* intended as a cooking blog framework – there's no RSS feed, no social sharing buttons, and absolutely zero SEO.

📓 Think of it as a **cookbook for nerds**.

Below the screenshots, you'll find some notes on [setting this tool up](#setup), [running it](#building), [formatting your recipes](#formatting), and [deploying the generated site](#deployment).

**Fork Notes: This fork is primarily intended for my personal use, and as a result has some changes and stuff trimmed off from the original. This includes rsync deployment and GitHub Actions code, parts of the README, as well as potential styling changes to come. You're likely better served by the original project, in [this repository](https://github.com/doersino/nyum). For more information on this fork, check out [the blog post about it](https://ineedmore.coffee/future-link).**

## Usage

### Initial Setup

Initial setup is pretty simple. The only dependency is [pandoc](https://pandoc.org) version >2.8. From there, the only things that need to be done are to fork/clone this repository, potentially clear out the `recipes/` and `docs/` directories to clear out the demo data, and go through `config.yaml` to configure the necessary settings.

To get it deployed on GitHub Pages, the best approach is to simply configure GitHub Pages to deploy from the `docs/` folder, which the script deploys to expressly because GitHub artificially limits Pages to only be able to deploy from the root of a repository or the `docs/` folder.

### Workflow

A general sample workflow for adding a new recipe would go as follows:

1. `git pull` to ensure your local copy is up to date and there's no merge conflicts.
2. Write your recipe in `recipes/` based on the formatting instructions below. Add any pictures to the same folder, with sensible filenames of course.
3. Build the site with `bash build.sh`.
4. Ensure everything looks correct by navigating to the `docs/` folder, then running a HTTP server to see what everything looks like (this can be done with Python using `python -m http.server`).
5. Commit and push the site, then wait a minute or two for GitHub Pages to reflect the changes!

### Formatting

TL;DR: See the example recipes in `recipes/`.

Each recipe **begins with YAML front matter specifying its title**, how many servings it produces, whether it's spicy or vegan or a favorite, the category, an image (which must also be located in the `recipes/` directory), and other information. Scroll down a bit for a list of possible entries – most of these are optional!

The **body of a recipe consists of horizontal-rule-separated steps, each listing ingredients relevant in that step along with the associated instruction**. Ingredients are specified as an unordered list, with ingredient amounts enclosed in backticks (this enables the columns on the resulting website – if you don't care about that, omit the backticks). The instructions must be preceded with a `>`. Note that a step can also solely consist of an instruction.

*You've got the full power of Markdown at your disposal – douse your recipes in formatting, include a picture for each step, and use the garlic emoji as liberally as you should be using garlic in your cooking!*

#### Example

```markdown
---
title: Cheese Buldak
original_title: 치즈불닭
category: Korean Food
description: Super-spicy chicken tempered with loads of cheese and fresh spring onions. Serve with rice and a light salad – or, better yet, an assortment of side dishes.
image: cheesebuldak.jpg
size: 2-3 servings
time: 1 hour
author: Maangchi
source: https://www.youtube.com/watch?v=T9uI1-6Ac6A
spicy: ✓
favorite: ✓
---

* `2 tbsp` chili flakes (gochugaru)
* `1 tbsp` gochujang
* `½-⅔ tbsp` soy sauce
* `1 tbsp` cooking oil
* `¼ tsp` pepper
* `2-3 tbsp` rice or corn syrup
* `2 tbsp` water

> Mix in an oven-proof saucepan or cast-iron skillet – you should end up with a thick marinade.

---

* `3-4 cloves` garlic
* `2 tsp` ginger

> Peel, squish with the side of your knife, then finely mince and add to the marinade.

---

> ⋯ (omitted for brevity)

---

> Garnish with the spring onion slices and serve.

```

#### YAML front matter

You *must* specify a non-empty value for the `title` entry. Everything else is optional:

* `original_title`: Name of the recipe in, say, its country of origin.
* `category`: Self-explanatory. Recipes belonging to the same category will be grouped on the index page. Don't name a category such that the generated category page will have the same URL as a recipe.
* `description` A short description of the dish, it will be shown on the index page as well.
* `nutrition`: Allows you to note down some nutrition facts for a recipe. Must take the form of a list, for example:
    ```yaml
    nutrition:
      - 300 calories
      - 60 g sugar
      - 0.8 g fat
      - 3.8 g protein
    ```
* `image`: Filename of a photo of the prepared dish, *e.g.*, `strawberrysmoothie.jpg`. The image must be located *alongside* the Markdown document – not in a subdirectory, for instance.
* `image_attribution` and `image_source`: If you haven't created the recipe photo yourself, you might be required to attribute its author or link back to its source (which should be an URL). The attribution, if set, will be shown semi-transparently in the bottom right corner of the image. If the source is non-empty, a click on the image will take you there.
* `size`: How many servings does the recipe produce, or how many cupcakes does it yield, or does it fit into a small or large springform?
* `time`: Time it takes from getting started to serving.
* `author`: Your grandma, for example.
* `source`: Paste the source URL here if the recipe is from the internet. If set, this will turn the `author` label into a link. If no author is set, a link labelled "Source" will be shown.
* `favorite`: If set to a non-empty value (*e.g.*, "✓"), a little star will be shown next to the recipe's name. It'll also receive a slight boost in search results.
* `veggie` and `vegan`: Similar and self-explanatory. If *neither* of these is set to a non-empty value, a "Meat" label will be shown.
* `spicy`, `sweet`, `salty`, `sour`, `bitter`, and `umami`: Similar – if set to a non-empty value, a colorful icon will be shown.

### Deployment

After running `build.sh`, **just chuck the contents of `docs/` onto a server of your choice**. 

**Fork Note:** A convenient consequence of choosing `docs/` as the build output is that **GitHub Pages will let you directly deploy the contents of the folder as a GitHub page**, no extra branches or separate repositories required. In my opinion, this is far superior to more complicated approaches with GitHub Actions, as it's simpler to understand and simpler to move somewhere else later.

### Updating

As bugs are fixed and features added (not that I expect much of either), you might wish to update your instance. Instead of adherence to versioning best-practices or even a semblance of an update scheme, here's instructions on how to perform a manual update:

1. Replace `assets/`, `templates/`, and `build.sh` of your instance with what's currently available in this repository.
2. Check if any new knobs and toggles have been added to `config.yaml` and adapt them into your `config.yaml`.

That should do it! (Perhaps build your site and inspect it to verify that nothing has broken – feel free to [file an issue](https://github.com/sohalsdr/nyum/issues) if something has.)

## License

You may use this repository's contents under the terms of the *MIT License*, see `LICENSE`.

However, the subdirectories `assets/fonts/` and `assets/tabler-icons` contain **third-party software with its own licenses**:

* The sans-serif typeface [**Barlow**](https://github.com/jpt/barlow) is licensed under the *SIL Open Font License Version 1.1*, see `assets/fonts/barlow/OFL.txt`.
* [**Lora**](https://github.com/cyrealtype/Lora-Cyrillic), the serif typeface used in places where Barlow isn't, is also licensed under the *SIL Open Font License Version 1.1*, see `assets/fonts/lora/OFL.txt`.
* The icons (despite having been modified slightly) are part of [**Tabler Icons**](https://tabler-icons.io), they're licensed under the *MIT License*, see `assets/tabler-icons/LICENSE.txt`. The placeholder image shown on the index page for recipes that don't have their own image if the `show_images_on_index` option is enabled also makes use of these icons.

Finally, some **shoutouts** that aren't *really* licensing-related, but fit better here than anywhere else in this document:

* The device mockups used to spice up the screenshots in this document are from [Facebook Design](https://design.facebook.com/toolsandresources/devices/).
* Because you're dying to know this, let me tell you that the screenshots' background image is based on a [Google Maps screenshot of a lithium mining operation in China](https://twitter.com/doersino/status/1324367617763676160).
* I've designed the logo using a previous project of mine, the [Markdeep Diagram Drafting Board](https://doersino.github.io/markdeep-diagram-drafting-board/).
