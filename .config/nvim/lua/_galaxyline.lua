local vim = vim
local gl = require('galaxyline')

local colors = {
    -- bg = '#292D38',
    -- bg = '#212434',
    -- fg = '#FCFDFF',
    section_bg = '#4A4B64',
    -- white = '#FFFFFF',
    -- yellow = '#DCDCAA',
    -- dark_yellow = '#D7BA7D',
    -- cyan = '#4EC9B0',
    -- green = '#608B4E',
    -- light_green = '#B5CEA8',
    -- string_orange = '#CE9178',
    -- orange = '#FF8800',
    -- purple = '#C586C0',
    -- magenta = '#D16D9E',
    grey = '#858585',
    -- blue = '#569CD6',
    -- vivid_blue = '#4FC1FF',
    -- light_blue = '#9CDCFE',
    -- red = '#D16969',
    -- error_red = '#F44747',
    -- info_yellow = '#FFCC66'

    -- bg_dark = "#1f2335",
    bg = "#24283b",
    bg_highlight = "#292e42",
    terminal_black = "#414868",
    fg = "#c0caf5",
    fg_dark = "#a9b1d6",
    fg_gutter = "#3b4261",
    dark3 = "#545c7e",
    comment = "#565f89",
    dark5 = "#737aa2",
    blue0 = "#3d59a1",
    blue = "#7aa2f7",
    cyan = "#7dcfff",
    blue1 = "#2ac3de",
    blue2 = "#0db9d7",
    blue5 = "#89ddff",
    blue6 = "#B4F9F8",
    blue7 = "#394b70",
    magenta = "#bb9af7",
    purple = "#9d7cd8",
    orange = "#ff9e64",
    yellow = "#e0af68",
    green = "#9ece6a",
    green1 = "#73daca",
    green2 = "#41a6b5",
    teal = "#1abc9c",
    red = "#f7768e",
    red1 = "#db4b4b"
}

local mode_color_schema = {
  n = colors.blue,
  i = colors.green,
  c = colors.orange,
  V = colors.magenta,
  [''] = colors.magenta,
  v = colors.magenta,
  R = colors.red,
}

local mode_color = function()
  return mode_color_schema[vim.fn.mode()]
end

local fileinfo = require('galaxyline.provider_fileinfo')
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = { 'NvimTree', 'vista', 'dbui', 'pack' }

local icons = {
    sep = {
        right = "",
        left = ""
    },
    diagnostic = {
        error = " ",
        warn = " ",
        info = " "
    },
    diff = {
        add = " ",
        modified = " ",
        remove = " "
    },
    git = "",
    file = {
      read_only = '',
      modified = '',
    }
}

local white_space = function() return ' ' end

local function file_name(is_active, highlight_group)
  Normal_fg = is_active and colors.fg or colors.grey
  Modified_fg = is_active and colors.red or colors.orange
  if vim.bo.modifiable then
    if vim.bo.modified then
      vim.api.nvim_command('hi ' .. highlight_group .. ' guifg='.. Modified_fg)
    else
      vim.api.nvim_command('hi ' .. highlight_group .. ' guifg='.. Normal_fg)
    end
  end
  return fileinfo.get_current_file_name(icons.file.modified, icons.file.read_only)
end

------------------------------------Left side----------------------------------------------------
local i = 1
gls.left[i] = {
  FirstElement = {
    provider = function()
      vim.api.nvim_command('hi GalaxyFirstElement guifg='..mode_color())
      return '' .. icons.sep.right
    end,
  },
}

i = i + 1
gls.left[i] = {
  Logo = {
    provider = function()
      vim.api.nvim_command('hi GalaxyLogo guibg='..mode_color())
      -- return '   '
      return '  '
    end,
    highlight = { colors.bg, colors.bg }
  },
}

i = i + 1
gls.left[i] = {
  ViMode = {
    provider = function()
      local alias = {
        n       = 'NORMAL ',
        i       = 'INSERT ',
        c       = 'COMMAND',
        V       = 'VISUAL ',
        ['']    = 'VISUAL ',
        v       = 'VISUAL ',
        R       = 'REPLACE',
      }
      vim.api.nvim_command('hi GalaxyViMode guibg='..mode_color()..' gui=bold')
      return '' .. alias[vim.fn.mode()]
    end,
    highlight = { colors.bg, colors.bg },
    -- separator = icons.sep.left,
    -- separator_highlight = {colors.bg, colors.section_bg},
  },
}

i= i + 1
gls.left[i] = {
  ViModeSep = {
    provider = function()
      vim.api.nvim_command('hi GalaxyViModeSep guifg='..mode_color()..' guibg='..colors.section_bg)
      return icons.sep.left .. ' '
    end,
  },
}

i = i + 1
gls.left[i] ={
  FileIcon = {
    provider = {white_space, 'FileIcon'},
    highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.section_bg },
  },
}

i = i + 1
gls.left[i] = {
  MyFileName = {
    provider = function() return file_name(true, 'GalaxyMyFileName') end,
    highlight = { colors.fg, colors.section_bg },
    separator = icons.sep.left .. ' ',
    separator_highlight = {colors.section_bg, colors.bg}
  }
}

i = i + 1
gls.left[i] = {
  GitIcon = {
    provider = function() return ' ' end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.orange, colors.bg}
  }
}

i = i + 1
gls.left[i] = {
  Space = {
    provider = white_space,
    highlight = {colors.bg, colors.bg},
  }
}

i = i + 1
gls.left[i] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.section_bg, colors.bg}
  }
}

i = i + 1
gls.left[i] = {
  Space = {
    provider = white_space,
    highlight = {colors.bg, colors.bg},
  }
}

i = i + 1
gls.left[i] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.green, colors.bg}
  }
}

i = i + 1
gls.left[i] = {
  Space = {
    provider = white_space,
    highlight = {colors.bg, colors.bg},
  }
}

i = i + 1
gls.left[i] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    icon = ' 柳',
    highlight = {colors.blue, colors.bg}
  }
}


i = i + 1
gls.left[i] = {
  Space = {
    provider = white_space,
    highlight = {colors.bg, colors.bg},
  }
}

i = i + 1
gls.left[i] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.red, colors.bg}
  }
}


------------------------------------Right side-----------------------------------------------------
local j = 1
gls.right[j] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = icons.diagnostic.error,
    highlight = {colors.red, colors.bg}
  }
}

j = j + 1
gls.right[j] = {
  Space = {
    provider = white_space,
    highlight = {colors.bg, colors.bg},
  }
}

j = j + 1
gls.right[j] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = icons.diagnostic.warn,
    highlight = {colors.orange, colors.bg},
  }
}

j = j + 1
gls.right[j] = {
  Space = {
    provider = white_space,
    highlight = {colors.bg, colors.bg},
  }
}

j = j + 1
gls.right[j] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = icons.diagnostic.info,
    highlight = {colors.yellow, colors.bg},
  }
}

-- j = j + 1
-- gls.right[j] = {
--   Space = {
--     provider = white_space,
--     highlight = {colors.bg, colors.bg},
--   }
-- }

j = j + 1
gls.right[j] = {
  TreesitterIcon = {
    provider = function()
        if next(vim.treesitter.highlighter.active) ~= nil then return ' ' end
        return ''
    end,
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.green, colors.bg}
  }
}

j = j + 1
gls.right[j] = {
  Space = {
    provider = white_space,
    highlight = {colors.bg, colors.bg},
  }
}

j = j + 1
gls.right[j] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = function()
        local tbl = {['dashboard'] = true, [' '] = true}
        if tbl[vim.bo.filetype] then return false end
        return true
    end,
    icon = '  ',
    highlight = {colors.fg, colors.bg}
  }
}

j = j + 1
gls.right[j] = {
  Space = {
    provider = white_space,
    highlight = {colors.bg, colors.bg},
  }
}

j = j + 1
gls.right[j] = {
  FirstSeparator = {
    provider = function() return icons.sep.right end,
    highlight = { colors.section_bg, colors.bg },
  }
}

j = j + 1
gls.right[j] = {
  LineInfo = {
    provider = 'LineColumn',
    highlight = { colors.fg, colors.section_bg },
    separator = ' ',
    separator_highlight = { colors.cyan, colors.section_bg },
  },
}

j = j + 1
gls.right[j] = {
  LastElement = {
    provider = function()
      -- vim.api.nvim_command('hi GalaxyLastElement guifg='..mode_color())
      return icons.sep.left
    end,
    highlight = { colors.section_bg, colors.bg }
  }
}

-- -------------------------Short status line---------------------------------------
local k = 1
gls.short_line_left[k] ={
  SFileIcon = {
    provider = 'FileIcon',
    highlight = { colors.fg, colors.bg },
  },
}

k = k + 1
gls.short_line_left[k] = {
  SMyFileName = {
    provider = function() return file_name(false, 'GalaxySMyFileName') end,
    highlight = {colors.fg, colors.bg},
    separator = icons.sep.left,
    separator_highlight = {colors.bg, colors.bg}
  }
}
