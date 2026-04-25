vim.filetype.add({
    extension = {
        asm = "nasm",
        h = "c",
        html = "htmldjango",
        mq4 = "cpp",
        mq5 = "cpp",
        mqh = "cpp",
        pan = "pan",
        wgsl = "wgsl",
    },

    pattern = {
        [".*/hypr/.*%.conf"] = "hyprlang",
    },
})
