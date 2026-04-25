local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local servers = {
    "clangd",
    "rust_analyzer",
    "pyright",
    "html",
    "marksman",
    "cssls",
    "texlab",
    "tinymist",
    "ts_ls",
}

local function config(server, opts)
    opts = opts or {}
    opts.capabilities = vim.tbl_deep_extend(
        "force",
        capabilities,
        opts.capabilities or {}
    )
    vim.lsp.config(server, opts)
end

config("clangd", {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
})

config("pyright", {})

config("marksman", {})

config("ts_ls", {})

config("html", {
    filetypes = { "html", "htmldjango" },
})

config("cssls", {
    filetypes = { "css", "scss" },
})

config("rust_analyzer", {
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "check",
            },
        },
    },
})

config("texlab", {
    settings = {
        texlab = {
            build = {
                args = {
                    "-lualatex",
                    "-interaction=nonstopmode",
                    "-synctex=1",
                    "%f",
                },
            },
        },
    },
})

config("tinymist", {
    root_dir = "/home/ashooww/Documents/mathan",
    settings = {
        formatterMode = "typstyle",
        exportPdf = "onSave",
        semanticTokens = "disable",
    },
    on_attach = function(client, bufnr)
        vim.keymap.set("n", "<leader>tp", function()
            client:exec_cmd({
                title = "pin",
                command = "tinymist.pinMain",
                arguments = { vim.api.nvim_buf_get_name(0) },
            }, { bufnr = bufnr })
        end, {
            buffer = bufnr,
            desc = "[T]inymist [P]in",
        })

        vim.keymap.set("n", "<leader>tu", function()
            client:exec_cmd({
                title = "unpin",
                command = "tinymist.pinMain",
                arguments = { vim.v.null },
            }, { bufnr = bufnr })
        end, {
            buffer = bufnr,
            desc = "[T]inymist [U]npin",
        })
    end,
})

require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_enable = false,
})

vim.lsp.enable(servers)

vim.api.nvim_create_user_command("OpenPdf", function()
    local filepath = vim.api.nvim_buf_get_name(0)

    if filepath:match("%.typ$") then
        local pdf_path = filepath:gsub("%.typ$", ".pdf")
        vim.system({ "zathura", pdf_path })
    end
end, {})
