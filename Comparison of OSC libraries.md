# Comparison of OSC libraries
I want to have Tranquility send OSC messages so it can interface with the SuperDirt synthesizer in supercollider. If I choose a library as opposed to writing my own I want it to prioritize the following:
- cross platform compatibility
- minimal additional dependencies
- open source license
- easy compilation/setup/configuration
- either be in LUA or in a language where wrappering its API with lua methods would be easy (cpp, c)

[list of libraries](https://opensoundcontrol.stanford.edu/page-list.html#implementations)

| library name                                          | lang | license | maintainer      | last commit | #commits2023 | #issues | tested?         | notes          |
|-------------------------------------------------------|------|---------|-----------------|-------------|--------------|---------|-----------------|----------------|
| [losc](https://github.com/davidgranstrom/losc)        | lua  | MIT     | david granstrom | 2021        | 0            | 4       | yes             | pure lua       |
| [liblo](https://liblo.sourceforge.net/)               | C    | GPL2    | Steve Harris    | 2021        | 0            | ?       | yes - highlevel | used by monome |
| [osc](https://luarocks.org/modules/gaspard/osc)       | lua  | MIT     | gasprd          |             |              |         |                 | wraps oscpack  |
| [oscpack](https://code.google.com/archive/p/oscpack/) | cpp  | MIT     | Ross Bencina    | 2014        | 0            | 9       | yes - highlevel | legacy         |
| [luaosc](https://github.com/koniu/luaosc)             | lua  | GPL     | koniu           | 2010        | 0            | ?       |                 | defunct        |
| WOscLib                                               | cpp  | LGPL    | Uli Franke      | 2005        | 0            | ?       |                 | legacy         |
|                                                       |      |         |                 |             |              |         |                 |                |
