settings.hintAlign = "center";

// Taken from built-in settings example from settings page
// -------------------------------------------------------
// set theme
settings.theme = `
.sk_theme {
    font-family: Consolas NF, Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 14pt;
}

#sk_banner {
    margin-top: 10px;
    border-radius: 3px;
    border: 0px;
    background: #FFE572;
    color: #000000;
    box-shadow: 0px 0px 12px #000000;
    font-size: 10pt;
    font-family: Consolas NF, monospace;
    font-weight: regular;
}
`;
// -------------------------------------------------------

// Hints
// -----
// https://github.com/brookhong/Surfingkeys/issues/323
// https://github.com/brookhong/Surfingkeys/blob/master/docs/API.md#hintsstyle
// https://gist.github.com/coramuirgen/94ba1d587cb2093c71f6ef4f0b371069

// Built-in #shadow-root>style content:
/*
div {
    position: absolute;
    display: block;
    font-size: 8pt;
    font-weight: bold;
    padding: 0px 2px 0px 2px;
    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#FFF785), color-stop(100%,#FFC542));
    color: #000;
    border: solid 1px #C38A22;
    border-radius: 3px;
    box-shadow: 0px 3px 7px 0px rgba(0, 0, 0, 0.3);
    width: auto;
}
div:empty {
    display: none;
}
[mode=text] div {
    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#aaa), color-stop(100%,#fff));
}
div.hint-scrollable {
    background: rgba(170, 170, 255, 0.85);
}
[mode=text] div.begin {
    color: #00f;
}
[mode=input] div {
    background: rgba(255, 217, 0, 0.25);
}
[mode=input] div.activeInput {
    background: rgba(0, 0, 255, 0.25);
}
*/

// Colors taken from Chrome devtools color picker:
// click on colorbox, then select Material in color palettes:
// - #00796B -> 2nd row, 1st box, 3rd in long press selector
// - #00897b ->      ...same but, 4th in long press selector
// - #c2185b -> 1st row, 2nd box, 3rd in long press selector
// - #ffeb3b -> 2nd row, 5th box, 5th in long press selector or just short press

api.Hints.style(`
  font-family: Segoe UI, sans-serif;
  font-size: 8pt;
  color: #000000;

  background: none;
  border: 0px;
  box-shadow: 0px 3px 7px 0px rgba(0, 0, 0, 0.7);
  padding: 1px 3px 2px 3px;

  background: #ffeb3b;

  /* original like theme */
  /*
  border: 1px solid #c38a22;
  background: #ffe572;
  padding: 0px 2px 0px 2px;
  */
`);
api.Hints.style(`div {
  font-family: Segoe UI, sans-serif;
  font-size: 8pt;
  color: #ffffff;

  background: none;
  border: 0px;
  box-shadow: 0px 3px 7px 0px rgba(0, 0, 0, 0.5);
  padding: 2px 4px 3px 4px;

  background: #00796B;
  @media (prefers-color-scheme: dark) {
    background: #00897b;
  }
}
div.begin{
  color: #ffffff;
}`, "text");

api.Visual.style('marks', 'background: unset; background: #ffc542; border-radius: 3px; opacity: 0.7;');
api.Visual.style('cursor', 'background: unset; background-color: #ff4081; border-radius: 1px;');

// Theme
//
// settings.theme = `
// .sk_theme {
//     background: ghostwhite;
//     color: #3d51f5;
//     font-family: Roboto, sans serif;
// }
// /* focused elements */
// .sk_theme .focused {
//     background: #3d51f5 !important;
//     color: ghostwhite;
// }
// .sk_theme input {
//     color: #ff4081;
// }
// .sk_theme .annotation {
//     color: #1a1d31;
//     font-size: 14px;
// }
// .sk_theme kbd {
//     color: #d0d0d0;
// }
// .sk_popup {
//     background-color: #ffffff;
// }
// /* Help/Guide (#sk_usage) */
// /**/
// #sk_usage, #sk_popup, #sk_editor {
//     padding: 1rem;
//     border: 1px solid #3d51f5;
//     background: radial-gradient(ghostwhite, white);
//     box-shadow: rgba(134, 134, 134, 0.8) 0px 2px 5px 0px;
// }
// #sk_usage > div {
//     vertical-align: top;
//     margin-right: 44px;
// }
// #sk_usage .feature_name {
//     padding-bottom: 14px;
//     padding-top: 18px;
// }
// .sk_theme .feature_name {
//     color: #ff4081;
// }
// #sk_usage .feature_name > span {
//     border-bottom: 2px solid #3d51f5;
//     font-size: 20px;
//     font-weight: bold;
//     font-family: ZillaSlab;
// }
// #sk_usage span.annotation {
//     padding-left: 13px;
//     line-height: 36px;
// }
// /* Shortcut text bubbles */
// #sk_usage .kbd-span {
//     width: 109px;
// }
// #sk_usage kbd {
//     background-color: white;
//     padding: 6px 4px 9px 4px;
//     font-family: Inconsolata;
//     font-size: 16px;
//     box-shadow: unset;
// }
// /* Slide-down banner for messages */
// /**/
// #sk_banner {
//     border-radius: 0px 0px 2px 2px;
//     border: 1px solid #ff4081;
//     background: radial-gradient(#ffece4, white);
//     color: #000a4a;
//     font-size: 14px;
//     font-weight: 500;
//     box-shadow: rgba(134, 134, 134, 0.8) 0px 2px 5px 0px;
// }
// /* Vim status tab (normal/insert/visual) */
// /**/
// #sk_status {
//     color: #2d51f5;
//     padding: 11px 8px 0 8px;
//     border: 1px solid #ff4081;
//     border-bottom: ghostwhite;
//     font-family: Nirmala UI Semilight;
//     font-size: 16px;
//     height: 1.8rem;
//     opacity: 0.5;
//     background: radial-gradient(ghostwhite, white);
//     box-shadow: 0px 1px 2px 0px rgba(0, 0, 0, 0.8);
//     border-radius: 2px 2px 0px 0px;
// }
// /* status tab inside */
// #sk_status > span {
//     line-height: 19px;
// }
// /* Omnibar styling */
// /**/
// #sk_omnibar {
//     background: radial-gradient(ghostwhite, white);
//     box-shadow: rgba(134, 134, 134, 0.8) 0px 2px 5px 0px;
//     border: 1px solid #3d51f5;
//     font-family: Nirmala UI Semilight;
// }
// #sk_omnibarSearchArea {
//     background-color: unset;
// }
// .sk_theme .prompt {
//     color: #cc9baa;
// }
// #sk_omnibarSearchArea > input {
//     color: #6483f9;
//     font-family: Nirmala UI Semilight;
//     margin-bottom: 1px;
// }
// .sk_theme .resultPage {
//     color: #6483f9;
// }
// #sk_omnibarSearchResult {
//     color: #6483f9;
//     font-size: 15px;
// }
// /* omnibar result rows */
// #sk_omnibar > #sk_omnibarSearchResult > ul > li {
//     padding: 0.3rem;
// }
// .sk_omnibar_middle #sk_omnibarSearchArea {
//     border-bottom: none;
// }
// /* omnibar results urls */
// .sk_theme .url {
//     color: #829dff;
// }
// /* omnibar selected result highlight */
// .sk_theme .omnibar_highlight {
//     color: #ff4081;
// }
// #sk_omnibar span.omnibar_highlight {
//     text-shadow: unset;
// }
// .sk_theme .omnibar_timestamp {
//     color: #86a4d2;
// }
// #sk_omnibarSearchResult > ul > li > .title > span.omnibar_folder {
//     color: #00bd55;
// }
// #sk_omnibarSearchResult > ul > li.focused > .title > span.omnibar_folder {
//     color: #00ff73;
// }
// /* Keystroke hints */
// #sk_richKeystroke {
//     border: 1px solid #3d51f5;
//     background: radial-gradient(ghostwhite, white);
//     box-shadow: rgba(134, 134, 134, 0.8) 0px 2px 5px 0px;
//     padding: 0.6rem 1rem 1rem 1rem;
//     border-radius: 2px;
// }
// #sk_richKeystroke kbd {
//     background-color: white;
//     padding: 9px 4px 11px 4px;
//     font-family: Inconsolata;
//     font-size: 20px;
//     box-shadow: unset;
//     border-color: #e6eaff;
// }
// #sk_richKeystroke .kdb-span {
//     min-width: 43px;
// }
// #sk_richKeystroke span.annotation {
//     color: #1a1d31;
//     padding-left: 13px;
//     line-height: 36px;
// }
// #sk_richKeystroke kbd > .candidates {
//     color: #ff4081;
//     font-weight: normal;
// }
// /*
// .interstitial-wrapper {
// }*/
// `;

// Configuration examples:
// - https://github.com/b0o/surfingkeys-conf
