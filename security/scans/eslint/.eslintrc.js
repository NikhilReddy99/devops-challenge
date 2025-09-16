module.exports = {
  env: {
    browser: true,
    es2021: true,
    node: false
  },
  extends: [
    "eslint:recommended",
    "plugin:react/recommended",
    "plugin:jsx-a11y/recommended"
  ],
  plugins: ["react", "jsx-a11y", "security"],
  rules: {
    "no-eval": "error",
    "no-inner-declarations": "error",
    "security/detect-object-injection": "warn",
    "react/prop-types": "off",
    "jsx-a11y/no-onchange": "warn"
  },
  settings: {
    react: {
      version: "detect"
    }
  }
};
