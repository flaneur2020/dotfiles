-- rime.lua
-- 全局 lua 入口。内联 mixed_case translator：
-- 当输入以大写字母开头且含数字时（如 K8s、A100、H100），生成
-- 「原样 / 全小写 / 全大写」三个候选，可用数字键/空格挑选。
-- recognizer 的 uppercase pattern（默认启用，来自 default.yaml）负责
-- 让大写字母开头的整串被接管，使其中的数字不被当作选词键。
-- 在 schema 里用 lua_translator@mixed_case_translator 挂载。

function mixed_case_translator(input, seg, env)
  -- 仅处理被 recognizer 标记为 uppercase 的段
  if not seg:has_tag("uppercase") then
    return
  end
  -- 仅当串中至少含一个数字时才介入；纯字母串（如 Hello）保持默认行为
  if not input:match("%d") then
    return
  end

  local lower = string.lower(input)
  local upper = string.upper(input)

  -- 第一个候选：原样（保留用户输入的大小写），quality 稍高以排到首位
  local c1 = Candidate("mixed", seg.start, seg._end, input, "原样")
  c1.quality = 10
  yield(c1)

  -- 全小写候选
  local c2 = Candidate("mixed", seg.start, seg._end, lower, "小写")
  c2.quality = 9
  yield(c2)

  -- 全大写候选
  local c3 = Candidate("mixed", seg.start, seg._end, upper, "大写")
  c3.quality = 8
  yield(c3)
end
