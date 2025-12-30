require('cairo')
require('cairo_xlib')

function conky_main()
    if conky_window == nil then return end
    local cs = cairo_xlib_surface_create(conky_window.display,
              conky_window.drawable,
              conky_window.visual,
              conky_window.width,
              conky_window.height)
    local cr = cairo_create(cs)

    cairo_set_source_rgba(cr, 0, 1, 0, 0.4)
    cairo_rectangle(cr, 0, 0, 200, 30)
    cairo_fill(cr)

    cairo_set_source_rgba(cr, 2, 3, 0, 0.4)
    cairo_rectangle(cr, 4, 4, 200, 30)
    cairo_fill(cr)

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
end

