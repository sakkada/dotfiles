local skkdlib = {}

function skkdlib.indexOf(table, value)
    -- gets index of value in a table
    -- usage example for get first value if value already is last: a[#a > idx and idx + 1 or 1]
    for idx, val in ipairs(table) do
        if value == val then
            return idx
        end
    end
    return nil
end

-- abandones in prefers for bufdelete
-- function skkdlib.deleteBufferSaveWindow()
--     -- local keymap = vim.keymap.set  -- TODO: use only keymap as map
--     -- keymap('n', '<Leader>bd', skkdlib.deleteBufferSaveWindow, {noremap = true})  -- delete current buffer without loosing any window if possible
--
--     if #vim.api.nvim_list_bufs() == 1 then
--         vim.api.nvim_create_buf(true, false)
--     end
--
--     local buf_num = vim.api.nvim_buf_get_number(0)
--     local buf_lst = vim.api.nvim_list_bufs()
--     local buf_idx = skkdlib.indexOf(buf_lst, buf_num)
--     local buf_nxt = buf_lst[#buf_lst > buf_idx and buf_idx + 1 or 1]
--     local windows = vim.api.nvim_list_wins()
--
--     for wi, w in ipairs(windows) do
--         if vim.api.nvim_win_get_buf(w) == buf_num then
--             vim.api.nvim_win_set_buf(w, buf_nxt)
--         end
--     end
--
--     local status, retval = pcall(vim.api.nvim_buf_delete, buf_num, {})
--     if not status then
--         print('DSFSDF')
--         print(status, retval)
--     end
-- end

return skkdlib
