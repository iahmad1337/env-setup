-- Things I might want to add:
-- -ACTION_ROTATION_SNAPPING
-- -ACTION_GRID_SNAPPING
-- -ACTION_RULER (Does this toggle ruler, or is there a way to specify on/off?)
-- Register all Toolbar actions and intialize all UI stuff
function initUi()
  app.registerUi({["menu"] = "Select Region", ["callback"] = "lasso", ["accelerator"] = "s"});
  app.registerUi({["menu"] = "Black Pen", ["callback"] = "black_pen", ["accelerator"] = "b"});
  app.registerUi({["menu"] = "Red Pen", ["callback"] = "red_pen", ["accelerator"] = "r"});
  app.registerUi({["menu"] = "Green Pen", ["callback"] = "green_pen", ["accelerator"] = "g"});
  -- app.registerUi({["menu"] = "Orange Pen", ["callback"] = "orange_pen", ["accelerator"] = "a"});
  -- app.registerUi({["menu"] = "Blue Highlighter", ["callback"] = "blue_highlighter", ["accelerator"] = "<Shift>f"});
  -- app.registerUi({["menu"] = "Red Highlighter", ["callback"] = "red_highlighter", ["accelerator"] = "<Shift>d"});
  -- app.registerUi({["menu"] = "Green Highlighter", ["callback"] = "green_highlighter", ["accelerator"] = "<Shift>s"});
  -- app.registerUi({["menu"] = "Yellow Highlighter", ["callback"] = "yellow_highlighter", ["accelerator"] = "<Shift>a"});
  app.registerUi({["menu"] = "Undo", ["callback"] = "undo", ["accelerator"] = "u"});
  app.registerUi({["menu"] = "Redo", ["callback"] = "redo", ["accelerator"] = "<Shift>r"});
  app.registerUi({["menu"] = "Copy", ["callback"] = "copy", ["accelerator"] = "c"});
  app.registerUi({["menu"] = "Paste", ["callback"] = "paste", ["accelerator"] = "v"});
  app.registerUi({["menu"] = "Cut", ["callback"] = "cut", ["accelerator"] = "x"});
  app.registerUi({["menu"] = "Delete", ["callback"] = "delete", ["accelerator"] = "d"});
  app.registerUi({["menu"] = "Eraser", ["callback"] = "eraser", ["accelerator"] = "e"});
end

--------------------
--  My functions  --
--------------------

-- Drawing styles
function dash_style()
  app.uiAction({["action"] = "ACTION_TOOL_LINE_STYLE_DASH"})
end

function plain_style()
  app.uiAction({["action"] = "ACTION_TOOL_LINE_STYLE_PLAIN"})
end

function rectangle()
  app.uiAction({["action"] = "ACTION_TOOL_DRAW_RECT"})
end

function arrow_style()
  app.uiAction({["action"] = "ACTION_TOOL_DRAW_ARROW"})
end

function default_style()
  -- according to the source code, default tool is a shape recognizer
  app.uiAction({["action"] = "ACTION_TOOL_DEFAULT"})
end

-- Utility

function new_page_after()
  app.uiAction({["action"] = "ACTION_NEW_PAGE_AFTER"})
end

function vertical_space()
  app.uiAction({["action"] = "ACTION_TOOL_VERTICAL_SPACE"})
end

function hand()
  app.uiAction({["action"] = "ACTION_TOOL_HAND"})
end

-----------------------------
--  Ben Smith's functions  --
-----------------------------


function lasso()
  app.uiAction({["action"] = "ACTION_TOOL_SELECT_REGION"})
end

function black_pen()
  app.uiAction({["action"] = "ACTION_TOOL_PEN"})
  app.changeToolColor({["color"] = 0x000000, ["tool"] = "pen"})
end

function red_pen()
  app.uiAction({["action"] = "ACTION_TOOL_PEN"})
  app.changeToolColor({["color"] = 0xEF0044, ["tool"] = "pen"})
end

function green_pen()
  app.uiAction({["action"] = "ACTION_TOOL_PEN"})
  app.changeToolColor({["color"] = 0x008000, ["tool"] = "pen"})
end

function orange_pen()
  app.uiAction({["action"] = "ACTION_TOOL_PEN"})
  app.changeToolColor({["color"] = 0xEF7000, ["tool"] = "pen"})
end

function blue_highlighter()
  app.uiAction({["action"] = "ACTION_TOOL_HIGHLIGHTER"})
  app.changeToolColor({["color"] = 0x20D0FF, ["tool"] = "highlighter"})
end

function red_highlighter()
  app.uiAction({["action"] = "ACTION_TOOL_HIGHLIGHTER"})
  app.changeToolColor({["color"] = 0xFF55FF, ["tool"] = "highlighter"})
--  app.changeToolColor({["color"] = 0xFF22FF, ["tool"] = "highlighter"})
end

function green_highlighter()
  app.uiAction({["action"] = "ACTION_TOOL_HIGHLIGHTER"})
  app.changeToolColor({["color"] = 0x00FF00, ["tool"] = "highlighter"})
end

function yellow_highlighter()
  app.uiAction({["action"] = "ACTION_TOOL_HIGHLIGHTER"})
  app.changeToolColor({["color"] = 0xEEFF00, ["tool"] = "highlighter"})
end

function undo()
  app.uiAction({["action"] = "ACTION_UNDO"})
end

-- This doesn't work?
function redo()
  app.uiAction({["action"] = "ACTION_REDO"})
end

function copy()
  app.uiAction({["action"] = "ACTION_COPY"})
end

function cut()
  app.uiAction({["action"] = "ACTION_CUT"})
end

function paste()
  app.uiAction({["action"] = "ACTION_PASTE"})
end

function delete()
  app.uiAction({["action"] = "ACTION_DELETE"})
end

function eraser()
  app.uiAction({["action"] = "ACTION_TOOL_ERASER"})
end

function select_object()
  app.uiAction({["action"] = "ACTION_TOOL_SELECT_OBJECT"})
end
