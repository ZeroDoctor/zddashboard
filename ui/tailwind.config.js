/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./web/**/*.{html,js,dart}"],
  theme: {
    extend: {},
  },
  daisyui: {
    themes: [
      {
        zdtheme: {
          "primary": "#3d73ba",
          "secondary": "#0d7da5",
          "accent": "#eabdf9",
          "neutral": "#202D3C",
          "base-100": "#1c1917",
          "info": "#67AFEF",
          "success": "#1E8F79",
          "warning": "#DB8906",
          "error": "#F05184",
        },
      },
    ],
  },
  plugins: [
    require("@tailwindcss/typography"),
    require("daisyui")
  ],
}

