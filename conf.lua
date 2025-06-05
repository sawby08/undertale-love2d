function love.conf(t)
    -- A menu for this will be made eventually
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
        fps = 30,
        fullscreen = false,
        gameScale = 1,
        
        bgmVolume = 0,
        sfxVolume = 1,
        textVolume = 1,
        mainVolume = 1
    }

    t.window.width = 640 * conf.gameScale
    t.window.height = 480 * conf.gameScale
    t.window.vsync = true
    t.window.fullscreentype = "desktop"
    t.window.resizable = false

    t.window.title = "UNDERTALE"
    t.window.icon = "icon.png"
end