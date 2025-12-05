# Hardtime.nvim Implementation Guide

## 🚀 What I've Added

I've installed `hardtime.nvim` with a conservative configuration that:
- **Preserves all your existing keymaps**
- **Doesn't interfere with your theme**
- **Only restricts basic hjkl spamming**
- **Provides helpful hints without being annoying**

## 📁 Files Modified

### 1. `lua/plugins/hardtime.lua` (NEW)
The main plugin configuration with sensible defaults.

## ⚙️ Configuration Details

### Safe Settings
- **max_time**: 1000ms (1 second window for repeated keys)
- **max_count**: 3 (allows 3 repetitions before blocking)
- **disable_mouse**: true (encourages keyboard usage)
- **allow_different_key**: true (resets count when you press different keys)

### Key Protections
- **Arrow keys**: Still allowed (not disabled)
- **Leader key**: All `<leader>` combinations work normally
- **Ctrl combinations**: All `<C-` keys work normally
- **Only restricts**: Basic `hjkl` spam in normal/visual mode

### Disabled Filetypes
Plugin won't interfere in:
- `lazy` (plugin manager)
- `mason` (LSP installer)
- `TelescopePrompt` (search)
- `dapui_*` (debugging)
- `neo-tree` (file explorer)
- `toggleterm` (terminal)

## 🎯 How It Works

### 1. **Movement Training**
Instead of: `jjjjjjjjjjjjjj`
You'll learn: `10j` or `Ctrl-D`

### 2. **Smart Hints**
- Spam `hjkl` → Get suggestion for better alternatives
- Bad patterns like `dt(i` → Suggests `ct(`

### 3. **Progress Tracking**
Run `:Hardtime report` to see your most common bad habits

## 🎮 Daily Usage

### First Week (Adjustment Period)
1. **Start noticing** when you spam hjkl
2. **Read the hints** that appear
3. **Try the suggested alternatives**
4. **Don't fight it** - let it guide you

### Common Scenarios

#### Scenario 1: Moving down several lines
❌ Bad: `jjjjjjjjjj`
✅ Good: `10j` or `Ctrl-D`

#### Scenario 2: Moving to a word
❌ Bad: `wwwwwwww`
✅ Good: `3w` or `f<first-letter>`

#### Scenario 3: Changing inside quotes
❌ Bad: `di"i`
✅ Good: `ci"`

## 🔧 Commands

```vim
:Hardtime enable    " Turn on training
:Hardtime disable   " Turn off temporarily
:Hardtime toggle    " Quick toggle
:Hardtime report    " View your habits
```

## 🎨 Theme Integration

The plugin uses your existing notification system:
- Works with catppuccin-mocha theme
- Uses nvim-notify if available
- No theme overrides

## 🚨 Troubleshooting

### If it feels too restrictive:
```vim
:Hardtime disable    " Temporary relief
```

### If it interferes with something:
Add the filetype to `disabled_filetypes` in the config.

### To check your progress:
```vim
:Hardtime report
```

## 📈 Expected Timeline

### Week 1: Frustration
- You'll notice how much you spam hjkl
- Hints might feel annoying
- **Stick with it!**

### Week 2-3: Adaptation
- Start using counts (`5j`, `3w`)
- Learning `f`, `t`, `F`, `T` motions
- Muscle memory building

### Week 4+: Mastery
- Efficient movements become natural
- Less reliance on hjkl spam
- Real speed improvements

## 🎯 Goal

The plugin isn't about being perfect - it's about **building awareness** of your movement patterns and gradually introducing more efficient alternatives.

## 🔄 Customization

If you want to adjust settings later, edit `lua/plugins/hardtime.lua`:

- **More restrictive**: Lower `max_count` to 2
- **Less restrictive**: Increase `max_time` to 2000
- **More hints**: Add custom patterns to `hints` table
- **Fewer hints**: Set `hint = false`

---

**Remember**: The plugin is training wheels for better Vim habits. You can always disable it temporarily if needed, but try to keep it enabled for the learning benefits!