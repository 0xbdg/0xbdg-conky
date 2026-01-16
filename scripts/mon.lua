require('cairo')
require('cairo_xlib')

function draw_hexagon(cr, cx, cy, size)
    local angle = math.pi / 3
    cairo_move_to(cr, cx + size, cy)

    for i = 1, 6 do
        cairo_line_to(
            cr,
            cx + size * math.cos(i * angle),
            cy + size * math.sin(i * angle)
        )
    end
    cairo_close_path(cr)
end

function draw_hex_percent(cr, cx, cy, size, percent, r, g, b, a)
    cairo_set_source_rgba(cr, r, g, b, a)
    cairo_set_line_width(cr, 6)

    draw_hexagon(cr, cx, cy, size)
    cairo_stroke_preserve(cr)

    cairo_clip(cr)
    cairo_rectangle(cr, cx - size, cy + size - (2 * size * percent), size * 2, size * 2)
    cairo_fill(cr)
    cairo_reset_clip(cr)
end

function conky_main()
    if conky_window == nil then return end

    local cs = cairo_xlib_surface_create(
        conky_window.display,
        conky_window.drawable,
        conky_window.visual,
        conky_window.width,
        conky_window.height
    )
    local cr = cairo_create(cs)
    local cpu = tonumber(conky_parse("${cpu}")) / 100
    local mem = tonumber(conky_parse("${memperc}")) / 100

    draw_hex_percent(cr, 150, 0, 60, cpu, 0.2, 0.8,1.0,0.9)
    draw_hex_percent(cr, 150, 120, 60, cpu, 0.2, 0.8, 1.0, 0.9)
    draw_hex_percent(cr, 150, 240, 60, mem, 1.0, 0.4, 0.4, 0.9)
    draw_hex_percent(cr, 50, 180, 60, mem, 2, 0.4, 0.4, 0.9)
    draw_hex_percent(cr, 250, 180, 60, mem, 2,0.4, 0.4, 0.9)
    draw_hex_percent(cr, 250, 60, 60, 12, 2,0.4, 0.4, 0.9)
    draw_hex_percent(cr, 50, 60, 60, 12, 2,0.4,0.4,0.9)

    cairo_select_font_face(cr, "Sans", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
    cairo_set_font_size(cr, 14)

    cairo_move_to(cr, 120, 120)
    cairo_show_text(cr, "CPU")

    cairo_move_to(cr, 105, 230)
    cairo_show_text(cr, "MEM")

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
end

