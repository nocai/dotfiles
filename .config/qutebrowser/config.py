# pyright: reportUndefinedVariable=false
# basic
config.set("content.notifications", False)
config.set("content.geolocation", False)
config.set("confirm_quit", ["downloads"])
config.set("downloads.location.prompt", False)
config.set("input.insert_mode.auto_leave", True)
config.set("tabs.last_close", "close")
config.set("content.autoplay", False)
config.set("content.pdfjs", True)
config.set("url.searchengines", {"DEFAULT": "https://google.com/search?q={}"})
config.set("url.default_page", "https://google.com")
config.set("url.start_pages", "https://google.com")
config.set("auto_save.session", False)
config.set("search.incremental", False)
config.set("qt.highdpi", True)
config.set(
    "editor.command",
    [
        "alacritty",
        "--title",
        "HOVER",
        "--command",
        "nvim",
        "{}",
    ],
)

# logical horizontal tab navigation
config.bind("J", "tab-prev")
config.bind("K", "tab-next")

# vimium c-like bindings
config.bind("F", "hint all tab-fg")
config.bind("d", "scroll-page 0 0.5")
config.bind("u", "scroll-page 0 -0.5")
config.bind("x", "tab-close")
config.bind("X", "undo")
config.unbind("xo")
config.unbind("xO")
# replace overridden bindings
config.bind("zo", "set-cmd-text -s :open -b")
config.bind("zO", "set-cmd-text :open -b -r {url:pretty}")

# leader bindings
config.bind(",R", "restart")
config.bind(",d", "download-open ;; download-clear")
config.bind(",D", "download-clear")
config.bind(",r", "config-cycle colors.webpage.darkmode.enabled ;; restart")

# other
config.bind("b", "hint all tab-bg")
config.bind("<Ctrl+n>", "completion-item-focus next", mode="command")
config.bind("<Ctrl+p>", "completion-item-focus prev", mode="command")

# visual
config.set("fonts.default_family", "Iosevka")
config.set("fonts.default_size", "13pt")
config.set("completion.height", "20%")

# continue loading autoconfig to allow persistent cycling
config.load_autoconfig()
# load theme
config.source("theme.py")
