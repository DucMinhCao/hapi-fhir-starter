module.exports = {
  "root": true,
  parser: "@typescript-eslint/parser",
  parserOptions: {
    project: 'tsconfig.json',
  },
  plugins: [
    "@typescript-eslint"
  ],
  extends: [
    'plugin:@typescript-eslint/recommended',
    "prettier"
  ],
  env: {
    node: true,
    browser: false,
    jest: false,
  },
  rules: {
    // Too restrictive, writing ugly code to defend against a very unlikely scenario: https://eslint.org/docs/rules/no-prototype-builtins
    "no-prototype-builtins": "off",
    // https://basarat.gitbooks.io/typescript/docs/tips/defaultIsBad.html
    "import/prefer-default-export": "off",
    "import/no-default-export": "error",
    // Use function hoisting to improve code readability
    "no-use-before-define": [
      "error",
      { functions: false, classes: true, variables: true },
    ],
    // Allow most functions to rely on type inference. If the function is exported, then `@typescript-eslint/explicit-module-boundary-types` will ensure it's typed.
    "@typescript-eslint/explicit-function-return-type": "off",
    "@typescript-eslint/no-use-before-define": [
      "error",
      { functions: false, classes: true, variables: true, typedefs: true },
    ],
    "@typescript-eslint/no-unsafe-assignment": "off",
    "import/no-default-export": "off",
    "quotes": ["error", "single"],
    semi: ["error", "never"]
  },
  overrides: [
    {
      files: ["*.js"],
      rules: {
        // Allow `require()`
        "@typescript-eslint/no-var-requires": "off",
      },
    },
  ],
};
