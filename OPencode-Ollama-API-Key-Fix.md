# OpenCode Ollama API Key Issue - Fix

## Problem
OpenCode is asking for an API key when connecting to local Ollama, but local Ollama doesn't require one.

## Solution

For local Ollama, you can use a dummy API key value. When prompted for an API key in `/connect`:

1. **Enter any dummy value** (e.g., `ollama`, `local`, or `no-key-needed`)
2. OpenCode will still connect to your local Ollama instance at `http://localhost:11434/v1`

The API key field is required by the UI, but Ollama's local endpoint doesn't actually validate it.

## Alternative: Use Environment Variables

You can also bypass the `/connect` step entirely by setting environment variables:

```bash
export OPENCODE_MODEL_PROVIDER="ollama"
export OPENCODE_BASE_URL="http://localhost:11434/v1"
export OPENCODE_MODEL_NAME="deepseek-coder-v2"
```

Then just run `opencode` - it should use these settings automatically.

## Verify It's Working

After connecting (even with a dummy API key), test it:
- Ask OpenCode a question about your code
- It should respond using your local Ollama model
- Check that it's actually using local (no network requests to external APIs)
