--[[ subtle glass tint — no grid ]]

require('cairo')
require('cairo_xlib')

function conky_glass_draw()
    if conky_window == nil then return end

    local w = conky_window.width
    local h = conky_window.height
    if w == nil or h == nil or w <= 0 or h <= 0 then return end

    local cs = cairo_xlib_surface_create(
        conky_window.display,
        conky_window.drawable,
        conky_window.visual,
        w, h
    )
    local cr = cairo_create(cs)

    cairo_set_source_rgba(cr, 0.05, 0.08, 0.14, 0.55)
    cairo_rectangle(cr, 0, 0, w, h)
    cairo_fill(cr)

    cairo_set_source_rgba(cr, 0.45, 0.72, 1.0, 0.35)
    cairo_rectangle(cr, 0, 0, 2, h)
    cairo_fill(cr)

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
end
