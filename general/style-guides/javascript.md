---
uid: style-guides-javascript
title: JavaScript
---

# JavaScript

## Tools

Projects generally provide EditorConfig and ESLint configurations to help you adhere to this style guide.

If one is not available or if you wish to start a new project, feel free to copy the existing files from one of the existing JavaScript projects.

## File Structure

### Filenames

Filenames must be camel case and may not include underscores (`_`) or dashes (`-`). The filename's extensions must be `.js`.

### General Structure

All files must abide by the following general structure, with JSDoc comments being optional but preferred:

```javascript
/**
 * This module documents the structure used by Javascript code in Jellyfin.
 *
 * @module path/to/this/module
 */

import module from 'dependency';
import { myFunction, myClass } from 'dependency/submodule';
import 'otherDependency';

export const name = 'Some name';

/**
 * Defines a non-exported function, accessible only from this module.
 *
 * @param {Object} argument - The argument to pass to the function.
 * @returns {Int|null} The resulting object from the function.
 */
function privateFunction (argument) {
    // Code ommitted
}

export function publicFunction (argument) {
    // Code ommitted
}

export default {
    name,
    publicFunction
}

```

### Imports

#### Naming

If the imported module doesn't respect the file naming conventions, convert its name to camel case when importing its default export, like such:

```javascript
import fileOne from '../file-one.js';
import fileTwo from '../file_two.js';
import fileThree from '../filethree.js';
```

## Formatting

### Braces

Braces are required for all control structures, even if the body contains only a single line.

They should respect the following rules:

* No line break before the opening brace
* Line break after the opening brace
* Line break before the closing brace
* Line break after the closing brace, except when the brace is followed by `else`, `catch`, `while`, or a comma, semicolon, or right-parenthesis.

An exception is made for statements than can fit on one line while remaining easily readable, where the following is accepted:

```javascript
if (shortCondition()) foo();
```

Furthermore, empty blocks like the following are allowed:

```javascript
function doNothing() {}
```

Array and Object literals should be formatted as blocks if they are long enough to impact readability.

### Indentation

Code should be indented with four (4) spaces per level.

### Statements

Statements should be limited to one per line and should be terminated by a semicolon.

## Language features

Jellyfin projects usually use fairly bleeding-edge JasvaScript features and are usually transpiled with Babel when aimed at being used in a browser.

> [!TIP]
> As a general recommendation, prefer the use of the latest features available, if enabled in the project you are submitting code to.

### Variables

Variable declarations must use `let` or `const`. Use `const` by default, unless the variable needs to be reassigned. Avoid the use of the `var` keyword.

Declare variable as close to their point where they are first used as possible, in order to their scope.

> [!NOTE]
> Avoid declaring multiple variables in one declaration.


### Arrays

Arrays should be declared on one line, as follows:

```javascript
const myArray = [240, 480, 720, 1080];
```

In cases where the array has a lot of elements or when readability could be improved, they should be declared with one element per line, as follows:

```javascript
const myArray = [
    'first value',
    'second value',
    // Code ommited
    'nth value'
];
```

> [!IMPORTANT]
> Do not use trailing commas when declaring arrays.

> [!CAUTION]
> Do not declare arrays with `new Array()` as it can be error-prone and is less readable than a literal.

### Objects

Objects should always be declared on multiple lines, as follows:

```javascript
const myObject = {
    a: 1,
    b: 2,
    c: 3
};
```

In cases where an object only has one element, it an be declared on one line, as follow:

```javascript
const myObject = { a: 1 };
```

> [!IMPORTANT]
> Do not use trailing commas when declaring arrays.

> [!INFO]
> Do not declare objects with `new Object()`. While it doesn't share the issues of the Array constructor, consistency is important.

Do not mix quoted and unquoted keys in a single object literal.


### Conditions

### Loops

When possible, avoid using basic loops. Prefer the use of `map()`, `forEach()`, `filter()`, `some()` or `every()`, as they make code more readable.

## Miscellaneous

### File Encoding

All files must be encoded in UTF-8 and use LF line endings when committed.

### Non-ASCII Characters

For printable characters, use the Unicode character directly in your code.

For non-printable characters, use the hexadecimal or Unicode escape.
