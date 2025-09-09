#!/usr/bin/env bash

# Test script for iTerm integration
# This script tests the iTerm setup function in isolation

# Source the provision script to get the functions
source /Users/balamurugank/sbrn/sys/hrt/provision-devlab-env.sh

echo "🧪 Testing iTerm2 Profile Setup Integration"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Test the setup_iterm_profiles function
echo "📝 Testing setup_iterm_profiles function..."
setup_iterm_profiles

echo ""
echo "✅ Test completed!"
echo ""
echo "📋 Function Status Check:"
echo "   • setup_iterm_profiles: $(declare -f setup_iterm_profiles > /dev/null && echo 'Defined' || echo 'Not found')"
echo "   • manage script: $(ls -la /Users/balamurugank/sbrn/sys/hrt/conf/terminal/manage-iterm-profiles.sh 2>/dev/null | cut -d' ' -f1)"
echo "   • colors dir: $(ls /Users/balamurugank/sbrn/sys/hrt/conf/terminal/colors/*.itermcolors 2>/dev/null | wc -l | tr -d ' ') color schemes"
echo "   • profiles dir: $(ls /Users/balamurugank/sbrn/sys/hrt/conf/terminal/profiles/*.json 2>/dev/null | wc -l | tr -d ' ') profile files"
