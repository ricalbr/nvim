local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

-- add snippets
ls.add_snippets('cpp', {
  -- base template
  s(
    'beg',
    fmt(
      [[
#include <bits/stdc++.h>

using namespace std;
typedef long long ll;

int32_t main(int argc, char *argv[]) {{
    {}

    return 0;
}}
  ]],
      { i(0) }
    )
  ),

  -- for loop
  s(
    'for',
    fmt(
      [[
for (int {} = 0; {} < {}; {}++) {{
    {}
}}
  ]],
      {
        i(1, 'i'), -- iteration variable
        rep(1), -- reference to same variable
        i(2, 'n'), -- limit condition
        rep(1), -- reference to iteration varible
        i(0), -- insert point
      }
    )
  ),
})
