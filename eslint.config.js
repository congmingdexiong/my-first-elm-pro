// 适用于 Elm 项目的基础配置（2025年4月）
module.exports = {
  // 指定根配置文件，停止向上查找 :ml-citation{ref="1,3" data="citationList"}
  root: true,

  // 忽略 Elm 文件（ESLint 默认不支持 Elm 语法）:ml-citation{ref="7" data="citationList"}
  ignorePatterns: ["**/*.elm"],

  // 配置解析器与规则（适用于混合 JavaScript/TypeScript 项目）
  parserOptions: {
    ecmaVersion: 2025,
    sourceType: "module",
  },
  env: {
    browser: true,
    es6: true,
  },
  rules: {
    "no-unused-vars": "warn",
    semi: ["error", "always"],
  },
};
