--[[ Casio world-time LCD — drawn with Cairo ]]

require('cairo')
require('cairo_xlib')

local FONT_TIME = 'DSEG7 Classic'
local FONT_MINI = 'DSEG7 Classic Mini'

local function rounded_rect(cr, x, y, w, h, r)
    cairo_new_sub_path(cr)
    cairo_arc(cr, x + w - r, y + r, r, -math.pi / 2, 0)
    cairo_arc(cr, x + w - r, y + h - r, r, 0, math.pi / 2)
    cairo_arc(cr, x + r, y + h - r, r, math.pi / 2, math.pi)
    cairo_arc(cr, x + r, y + r, r, math.pi, 3 * math.pi / 2)
    cairo_close_path(cr)
end

local function text_extents(cr, text)
    local ext = cairo_text_extents_t:create()
    cairo_text_extents(cr, text, ext)
    return ext.width, ext.height, ext.y_bearing
end

local function baseline_y(cr, text, box_y, box_h)
    local _, th, y_bearing = text_extents(cr, text)
    return box_y + (box_h - th) / 2 - y_bearing
end

function conky_watch_draw()
    if conky_window == nil then return end

    local ww = conky_window.width
    local wh = conky_window.height
    if ww <= 0 or wh <= 0 then return end

    local cs = cairo_xlib_surface_create(
        conky_window.display,
        conky_window.drawable,
        conky_window.visual,
        ww, wh
    )
    local cr = cairo_create(cs)

    local inset = 10
    local bx, by, bw, bh = 2, 8, ww - 4, 54
    local cx = bx + inset
    local cy = by + inset
    local cw = bw - inset * 2
    local ch = bh - inset * 2

    local time = os.date('%H:%M')
    local day = os.date('%a'):upper()
    local date = string.format('%d %s', tonumber(os.date('%d')), os.date('%b'):upper())

    cairo_select_font_face(cr, FONT_TIME, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
    cairo_set_font_size(cr, 36)
    local tw, th = text_extents(cr, time)

    cairo_select_font_face(cr, FONT_MINI, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
    cairo_set_font_size(cr, 14)
    local dw, dh = text_extents(cr, day)
    local rw, rh = text_extents(cr, date)

    local divx = cx + cw / 2
    local left_col_w = cw / 2
    local right_col_w = cw / 2

    -- bezel
    rounded_rect(cr, bx, by, bw, bh, 8)
    cairo_set_source_rgba(cr, 0.04, 0.06, 0.10, 0.50)
    cairo_fill_preserve(cr)
    cairo_set_source_rgba(cr, 0.55, 0.82, 0.90, 0.30)
    cairo_set_line_width(cr, 1)
    cairo_stroke(cr)

    -- divider (even vertical inset)
    cairo_set_source_rgba(cr, 0.55, 0.82, 0.90, 0.55)
    cairo_set_line_width(cr, 1)
    cairo_move_to(cr, divx, cy)
    cairo_line_to(cr, divx, cy + ch)
    cairo_stroke(cr)

    -- time — centered in left column
    cairo_select_font_face(cr, FONT_TIME, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
    cairo_set_font_size(cr, 36)
    cairo_set_source_rgba(cr, 0.96, 0.98, 1.0, 1.0)
    local time_x = cx + (left_col_w - tw) / 2
    local time_y = baseline_y(cr, time, cy, ch)
    cairo_move_to(cr, time_x, time_y)
    cairo_show_text(cr, time)

    -- day + date — centered in right column
    cairo_select_font_face(cr, FONT_MINI, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
    cairo_set_font_size(cr, 14)
    cairo_set_source_rgba(cr, 0.80, 0.93, 0.98, 1.0)
    local line_gap = 5
    local block_h = dh + line_gap + rh
    local block_y = cy + (ch - block_h) / 2
    local day_x = divx + (right_col_w - dw) / 2
    local date_x = divx + (right_col_w - rw) / 2
    local day_y = baseline_y(cr, day, block_y, dh)
    local date_y = baseline_y(cr, date, block_y + dh + line_gap, rh)

    cairo_move_to(cr, day_x, day_y)
    cairo_show_text(cr, day)
    cairo_move_to(cr, date_x, date_y)
    cairo_show_text(cr, date)

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
end
