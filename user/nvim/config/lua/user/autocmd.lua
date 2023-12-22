vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.dart",
    group = vim.api.nvim_create_augroup("Learning in TJ video", {clear = true}),
    callback = function()
        local format_command = {"dart", "format", vim.api.nvim_buf_get_name(0)}
        local format_job_id = vim.fn.jobstart(format_command, {
            on_exit = function(_, code, _)
                if code == 0 then
                    vim.cmd('e!')
                end
            end,
        })
    end,
})
