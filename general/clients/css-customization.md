---
uid: clients-css-customization
title: CSS Customization
---

# CSS Customization

In "Dashboard>General", the "Custom CSS" field can be used to enter any override, that will then apply to the CSS stylesheet of Jellyfin.

[Custom CSS](https://developer.mozilla.org/en-US/docs/Web/CSS) provides interface customization such as changing colors, layout, item size and behavior. Below is a list of various modifications that can be applied. The CSS modifications work on both the web client, and the android app. The code will apply in the order that it is written so code can override previously stated custom CSS, `!important` will overrule everything. To learn more see [CSS Specificity](https://developer.mozilla.org/en-US/docs/Web/CSS/Specificity). To implement these changes, go to Dashboard > General > Custom CSS. An additional source for specificity is [specifishity](https://specifishity.com/).

If you have little or no experience with CSS, various resources and tutorials can be found online, together with using the below modifications as examples it is quite easy to get started making your own changes to your Jellyfin instance.

![Screenshot of the 'Custom CSS' setting in the administrator dashboard of the web client](~/images/custom-css-customcssfield.png)

## General Information About CSS

You can learn more about CSS using sites like [w3school](https://www.w3schools.com/css/default.asp). Below are some very basic details that will let you do rudimentary edits to the ready made modifications below.

### Colors

CSS supports multiple color formats, most typically hex is used. But simply text works too. To get "yellow" you can simply write "yellow", this will use a preset yellow color. To get a speciphic color, exact color data such as the hex codes below have to be used.

Some examples of hex color codes:

`#5dd000` Green <br>
`#0000d0` Blue <br>
`#d00000` Red <br>
`#00000058` Transparent black

Go [here](https://htmlcolorcodes.com/color-picker/) for a hex color chart to get a code for any given color.

### Comments

A section of code or text inbetween `/*` and `*/` indicate a comment, and will be ignored. This allows you to add descriptions for what any particular section of code does to make it easily identifiable. It can also be used to disable code without deleting it. For example

`/* This might be added above code to tell you what it does */`

### CSS Chaining

CSS can be chained together to modify different sections together. An example of this is the "Border color" mod. It lists elements to be modified, and performs a change that is applied to all of them.

## Modifications List

To apply any one of these, copy paste the CSS code into the "Custom CSS" field. To use multiple modifications, simply add them one after another into the field. Any applied code will remain in the field. To remove a modification, delete or comment out the code for it from the field. Changes apply immediately when the settings page is saved and doesn't require restarting.

### Played Indicator

This will affect the played/watched indicator. Replace the color hex with any value you like.

#### Indicators Without Mod

![Screenshot of the default watched indicators](~/images/custom-css-normalwatched.png)

#### Green Indicators

```css
.playedIndicator { background: #5dd000; }
```

![Screenshot of watched indicators with a custom green color applied](~/images/custom-css-greenwatched.png)

#### Transparent And Dark Indicators (using RGBA hex value)

```css
/* Make watched icon dark and transparent */
.playedIndicator {background: #00000058;}
```

![Screenshot of watched indicators with a custom transparent color applied](~/images/custom-css-transparentwatched.png)

#### Remove Live TV Channel Listings

```css
.guideChannelNumber { display: none; }
```

#### Reduce Live TV Channel Width

```css
.channelsContainer { max-width: 8em; }
```

### Transparent Top Menu

Self explanatory

```css
/* Top menu transparency */
.skinHeader.focuscontainer-x.skinHeader-withBackground.skinHeader-blurred {background:none; background-color:rgba(0, 0, 0, 0);}
.skinHeader.focuscontainer-x.skinHeader-withBackground.skinHeader-blurred.noHomeButtonHeader {background:none; background-color:rgba(0, 0, 0, 0);}
```

### Enlarge Tab Buttons

Enlarges the tab buttons, suggested, genres, etc. By default they are really damn tiny, especially on mobile.

```css
/* Adjust both "size-adjust" and "size" to modify size */
.headerTabs.sectionTabs {text-size-adjust: 110%;  font-size: 110%;}
.pageTitle {margin-top: auto; margin-bottom: auto;}
.emby-tab-button {padding: 1.75em 1.7em;}
```

**The enlarged tab buttons and transparent menu look like this:**
![Screenshot of enlarged tab buttons and transparent menu](~/images/custom-css-transparenttopbarenlargedtabs.png)

### Minimalistic Login Page

This looks even better together with the transparent top menu.

```css
/* Narrow the login form */
#loginPage .readOnlyContent, #loginPage form {max-width: 22em;}

/* Hide "please login" text, margin is to prevent login form moving too far up */
#loginPage h1 {display: none}
#loginPage .padded-left.padded-right.padded-bottom-page {margin-top: 50px}

/* Hide "manual" and "forgot" buttons */
#loginPage .raised.cancel.block.btnManual.emby-button {display: none}
#loginPage .raised.cancel.block.btnForgotPassword.emby-button {display: none}
```

![Screenshot of the minimalistic login page](~/images/custom-css-minimallogin.png)

### Stylized Episode Previews

The episode previews in season view are sized based on horizontal resolution, this leads to a lot of wasted space on the episode summary and a high vertical page requiring a lot of scrolling to browse. This code reduces the height of episode entries to reduce the need for vertical scrolling on large screens.

```css
/* Size episode preview images in a more compact way */
.listItemImage.listItemImage-large.itemAction.lazy {height: 110px;}
.listItem-content {height: 115px;}
.secondary.listItem-overview.listItemBodyText {height: 61px; margin: 0;}
```

![Screenshot of a TV show page with stylized episode previews](~/images/custom-css-episodepreview.png)

### Stylized and Smaller Cast Info

This will drastically change the style of cast info into something very similar to how plex does it. The Purple Haze theme already has rounded cast info, but at the same large size as everything else, this override will lead to somewhat smaller thumbnails, and also works with all other themes.

```css
/* Shrink and square (or round) cast thumnails */
#castContent .card.overflowPortraitCard.personCard.card-hoverable.card-withuserdata {width: 4.2cm !important; font-size: 90% !important;}
#castContent .card.overflowPortraitCard.personCard.card-withuserdata {width: 4.2cm !important; font-size: 90% !important;}

/* Correct image aspect ratio behaviour, set border-radius to zero for square tiles */
#castContent .cardContent-button.cardImageContainer.coveredImage.cardContent.cardContent-shadow.itemAction.lazy {background-size: cover; !important; border-radius: 2.5cm;}
#castContent .cardContent-button.cardImageContainer.coveredImage.defaultCardBackground.defaultCardBackground1.cardContent.cardContent-shadow.itemAction {background-size: cover; !important; border-radius: 2.5cm;}
#castContent .cardContent-button.cardImageContainer.coveredImage.defaultCardBackground.defaultCardBackground2.cardContent.cardContent-shadow.itemAction {background-size: cover; !important; border-radius: 2.5cm;}
#castContent .cardContent-button.cardImageContainer.coveredImage.defaultCardBackground.defaultCardBackground3.cardContent.cardContent-shadow.itemAction {background-size: cover; !important; border-radius: 2.5cm;}
#castContent .cardContent-button.cardImageContainer.coveredImage.defaultCardBackground.defaultCardBackground4.cardContent.cardContent-shadow.itemAction {background-size: cover; !important; border-radius: 2.5cm;}
#castContent .cardContent-button.cardImageContainer.coveredImage.defaultCardBackground.defaultCardBackground5.cardContent.cardContent-shadow.itemAction {background-size: cover; !important; border-radius: 2.5cm;}
#castContent .cardScalable {width: 3.8cm !important; height: 3.8cm !important; border-radius: 2.5cm;}
#castContent .cardOverlayContainer.itemAction {border-radius: 2.5cm;}

/* Center the mouseover buttons */
#castContent .cardOverlayButton-br {bottom: 4%; right: 15%; width: 70%;}
#castContent .cardOverlayButton.cardOverlayButton-hover.itemAction.paper-icon-button-light {margin:auto;}
```

![Screenshot of stylized and smaller cast and crew info](~/images/custom-css-stylizedcast.png)

### Custom Background Color

```css
.backgroundContainer, .dialog, html { background-color: #0fd0d0; }
```

### Darken the Background

This darkens the background on blue radiance and purple haze, edit the percentage depending how dark you want it. Lower is darker.

```css
/* Darken background, only works with blue radiance */
.backgroundContainer {background-color: #000000; filter: brightness(50%);}
```

### Right Header Color

This modifies the colors of the cast, search and user buttons in the top right.

```css
.headerRight { color: yellow; }
```

![Screenshot of a custom yellow color for the icon buttons in the top right of the screen](~/images/custom-css-rightheader.png)

### Console Panel Custom Color

Modifies the color of the left menu panel.

```css
.mainDrawer-scrollContainer { color: yellow; }
```

![Screenshot of a custom yellow color on the left menu panel](~/images/custom-css-consolepanel.png)

### General Page Custom Color

```css
.dashboardGeneralForm { color: yellow; }
```

![Screenshot of a custom yellow color on the General Page](~/images/custom-css-generalcolor.png)

### Custom Border Color

This will change the border color for text fields and drop down menus.

```css
.emby-input, .emby-textarea, .emby-select { border-color: #d00000; }
```

This will affect the border color of highlighet(selected) text fields and drop down menus.

```css
.emby-input:focus, .emby-textarea:focus, .emby-select-withcolor { border-color: #ffffff !important; }
```

![Screenshot of a custom red border color](~/images/custom-css-bordercolor.png)

### Full Header Mod

```css
.skinHeader, .mainDrawer, .emby-input, .emby-textarea, .emby-select, .navMenuOption-selected, .cardBox, .paperList { background: #ff9475; }
```

![Screenshot of the full header mod](https://user-images.githubusercontent.com/20715731/73949397-5f6f2500-48c8-11ea-9eca-bc1eb61f1281.png)

### Scrollerless Libraries

This will make it so libraries and media fits neatly onto the homepage with no left to right scrolling required.

```css
@media all and (min-width: 50em) {
  .homePage .emby-scroller {
    margin-right: 0;
  }
  .homePage .emby-scrollbuttons {
    display: none;
  }
  .homePage .itemsContainer {
    flex-wrap: wrap;
  }
}
```
### Shift Scroller Buttons

```css
.emby-scrollbuttons {
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    padding: 0;
    justify-content: space-between;
    pointer-events: none;
}
.emby-scrollbuttons-button {
    pointer-events: initial;
}
```

### Hotdogs and Catsup

An example of a color theme.

![Screenshot of a hotdog and catsup color theme](https://user-images.githubusercontent.com/20715731/73948929-a3adf580-48c7-11ea-8bf1-eaaba2873be7.png)

```css
.skinHeader, .mainDrawer, .emby-input, .emby-textarea, .emby-select, .navMenuOption-selected, .cardBox, .paperList {
    background: #ff9475;
}

.emby-input, .emby-textarea, .emby-select {
    border-color: #fdbe7d;
}

.backgroundContainer.withBackdrop, .backdropContainer, .backgroundContainer {
    background: #fdbe7d;
}

#myPreferencesMenuPage .listItemBodyText,
.emby-tab-button[data-index="0"],
#myPreferencesMenuPage > div > div > div > a:nth-child(odd),
.button-submit,
.mainAnimatedPage *:nth-child(odd),
.dashboardGeneralForm *:nth-child(odd),
.mainDrawer-scrollContainer *:nth-child(odd),
.headerRight *:nth-child(odd) {
    color: red;
}

#myPreferencesMenuPage .listItemIcon,
.emby-tab-button[data-index="1"],
#myPreferencesMenuPage > div > div > div > a:nth-child(even),
.mainAnimatedPage *:nth-child(even),
.dashboardGeneralForm *:nth-child(even),
.mainDrawer-scrollContainer *:nth-child(even),
.headerRight *:nth-child(even)
.cancel {
    color: yellow;
}
```

### Floating Now Playing Controls

![Screenshot of the floating "Now Playing" controls](~/images/custom-css-floatingnowplaying.png)

```css
/* fixed height for the bottom row */
:root {
  --element-fixed-top: 95px;
}

/* Now playing bar in the footer */
.nowPlayingBar {
       width: 650px;
       z-index: 10;
       position: fixed;
       top: 300px;
       height: 120px;
      border-style: solid;
      border-color: white;
      background-color: black;
      margin-left: 50%;
}

/* Only child of nowPlayingBar */
.nowPlayingBarTop {
     height: 5px !important;
     max-width: 500px
     top: 10px;
}

/* Song progress seekbar */
.nowPlayingBarPositionContainer {
     position: relative;
     top: 1.0em !important;
}

/* Container that holds album thumbnail, artist and album name */
.nowPlayingBarInfoContainer {
     position: fixed !important;
     left: 12px;
     top: 34px;
     height: 60px;
     width: 1100px;
}

/* Holds the next, previous track, play/pause, next and time elements */
.nowPlayingBarCenter {
     position: relative !important;
     left: 32px;
     top: var(--element-fixed-top);
     min-width: 500px;
}

/* Hold mute, volume slider container, repeat, favorite and remote control buttons */
.nowPlayingBarRight {
     width: 402px !important;
     left: -60px;
}

/* Mute button */
.muteButton {
    position: relative;
    top: var(--element-fixed-top);
}

/* Volume slider */
.nowPlayingBarVolumeSliderContainer {
     position: relative;
     left: -4px;
     top: var(--element-fixed-top);
}

/* Toggle repeat */
.toggleRepeatButton {
     position: relative !important;
     left: -20px;
     top: var(--element-fixed-top);
}

/* Favorite */
.nowPlayingBarUserDataButtons {
     position: relative;
     left: -4px;
     top: var(--element-fixed-top);
}

/* Remote control */
.remoteControlButton {
     left: -110px;
     top: var(--element-fixed-top);
}
```

## Community Links

Some links to places where custom CSS has been discussed and shared.

- [Custom CSS Guide](https://www.reddit.com/r/jellyfin/comments/fgmu6k/custom_css_updated_for_1050/)
- [Easy Jellyfin custom CSS](https://www.reddit.com/r/jellyfin/comments/crxqk5/easy_jellyfin_custom_css/)
- [Custom CSS with Emby Web App](https://emby.media/community/index.php?/topic/18046-custom-css-with-emby-web-app/)
