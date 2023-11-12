module.exports = {
  plugins: [require("@tailwindcss/typography"), require("daisyui")],
  content: ['./src/**/*.{html,js,svelte,ts}'],
  theme: {
    extend: {},
    screens: {
      'xs': '312px',
      // => @media (min-width: 312px) { ... }

      'sm': '640px',
      // => @media (min-width: 640px) { ... }

      'md': '768px',
      // => @media (min-width: 768px) { ... }

      'lg': '1024px',
      // => @media (min-width: 1024px) { ... }

      'xl': '1280px',
      // => @media (min-width: 1280px) { ... }

      '2xl': '1536px',
      // => @media (min-width: 1536px) { ... }
    }
  },
  daisyui: {
    themes: [
      {
        zdtheme: {
          "primary": "#bae6fd",
          "secondary": "#e7e5e4",
          "accent": "#fef08a",
          "neutral": "#292524",
          "base-100": "#1c1917",
          "info": "#0ea5e9",
          "success": "#22c55e",
          "warning": "#eab308",
          "error": "#e11d48"
        }
      }
    ]
  }
}
