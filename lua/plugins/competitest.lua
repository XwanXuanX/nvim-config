return {
  "xeluxee/competitest.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },

  config = function()
    local build_dir = ".competitest/build"

    ---@diagnostic disable-next-line: missing-fields
    require("competitest").setup({
      compile_directory = build_dir,
      running_directory = build_dir,

      compile_command = {
        cpp = {
          exec = "g++",
          args = {
            "-std=c++17",
            "-Wall",
            "-Wextra",

            "-I",
            vim.fn.expand("/home/wanxuan/abstract-nonsense"),

            "$(FABSPATH)",
            "-o",
            "$(FNOEXT)",
          },
        },
      },

      run_command = {
        cpp = {
          exec = "./$(FNOEXT)",
        },
      },

      -- load custome template
      evaluate_template_modifiers = true,
      template_file = vim.fn.expand("/home/wanxuan/abstract-nonsense/template.cpp"),

      -- place testcases inside a hidden dir
      testcases_directory = ".competitest",
      testcases_use_single_file = true,
      testcases_auto_detect_storage = true,
    })
  end,
}
