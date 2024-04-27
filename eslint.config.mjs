import globals from "globals";
import pluginJs from "@eslint/js";
import babelParser from "@babel/eslint-parser";
import eslintPluginMarkdownlint from "eslint-plugin-markdownlint";
import markdownlintParser from "eslint-plugin-markdownlint/parser.js"; 

import { FlatCompat } from "@eslint/eslintrc";
import path from "path";
import { fileURLToPath } from "url";

// mimic CommonJS variables -- not needed if using CommonJS
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const compat = new FlatCompat({
    baseDirectory: __dirname
});

export default [
  pluginJs.configs.recommended,
  ...compat.extends("plugin:Markdownlint/recommended"),
  {
    files: ["**/*.js"],
    languageOptions: {
      //parser: jsParser
      //parser: babelParser,
      sourceType: "commonjs",
    }
  },
  // Terrible --fix for markdownlint
  {
    files: ["**/*.md"],
    languageOptions: {
      //parser: markdownEslintParser
      //parser: "eslint-plugin-markdownlint/parser"
      parser: markdownlintParser
    },
    plugins: {
      markdownlint: eslintPluginMarkdownlint
    },
    rules: {
      "markdownlint/md001": "off",
      "markdownlint/md003": "warn",
      "markdownlint/md025": ["error", {
        "level": 2
      }]
    }
  }
];