function love.conf(t)
    t.window.width = 640
    t.window.height = 480
    t.window.vsync = true
    t.window.fullscreentype = "desktop"
    t.window.resizable = false

    t.window.title = "UNDERTALE"
    t.window.icon = "icon.png"

    conf = {
        keys = {
            up = {'up', 'w'},
            down = {'down', 's'},
            left = {'left', 'a'},
            right = {'right', 'd'},
            primary = {'z', 'return'},
            secondary = {'x', 'lshift', 'rshift'},
            fullscreen = {'f4'}
        },
        fps = 30
    }
end