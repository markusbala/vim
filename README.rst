=============================
⚡ Ultimate Vim Developer Setup
=============================

A professional Vim configuration optimized for **Python** and **RST** development, featuring Intellisense (LSP), Fuzzy Search, and Git integration.

📋 Prerequisites
----------------

Before running the installer, ensure you have these tools installed on your system:

1. **Vim** (version 8.1 or higher)
2. **Git** (Required for plugins)
3. **Python 3** + pip (Required for Black formatter & UltiSnips)
    * ``pip install black pynvim``
4. **Node.js** (Required for CoC Intellisense)
5. **Ripgrep** (Required for fast text search)
6. **Nerd Font** (Required for icons)
    * *Recommendation:* `Hack Nerd Font <https://www.nerdfonts.com/font-downloads>`_ (Set this as your terminal font).

🚀 Installation
---------------

🐧 Linux / macOS
~~~~~~~~~~~~~~~~

1. Clone this repository:

   .. code-block:: bash

      git clone https://github.com/markusbala/vim.git
      cd vim

2. Run the setup script:

   .. code-block:: bash

      chmod +x install.sh
      ./install.sh

🪟 Windows
~~~~~~~~~~

1. Clone this repository:

   .. code-block:: cmd

      git clone https://github.com/markusbala/vim.git
      cd vim

2. Double-click ``install.bat`` or run it from the command line.

🎹 Key Shortcuts Cheat Sheet
----------------------------

.. list-table::
   :widths: 20 80
   :header-rows: 1

   * - Key
     - Action
   * - **Leader Key**
     - ``,`` (Comma)
   * - **F3**
     - Toggle File Tree (NERDTree)
   * - **Ctrl + p**
     - Fuzzy Find Files (FZF)
   * - **Ctrl + n**
     - Toggle Auto-complete (CoC)
   * - **Ctrl + j**
     - Expand Snippet / Jump to next Snippet area
   * - ``,f``
     - Find current file in Tree
   * - ``,b``
     - Search Open Buffers
   * - ``,g``
     - Search Text inside files (Ripgrep)
   * - ``,s``
     - Save Session
   * - ``,w``
     - Quick Save file
   * - **F5**
     - Run Python File
   * - ``gd``
     - Go to Definition
   * - ``K``
     - Show Documentation
   * - ``gcc``
     - Comment/Uncomment Line
   * - ``cs"'``
     - Change surrounding ``"`` to ``'``

🛠 Post-Install Step
--------------------

After installation, open Vim. It might take a moment to download the CoC extensions. If auto-complete isn't working immediately, run this command inside Vim once:

.. code-block:: vim

   :CocInstall coc-pyright coc-snippets coc-json coc-html coc-css coc-yaml