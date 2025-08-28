"""
Production settings entrypoint for Docker/CI.
This module simply re-exports settings defined in deploy/settings_production.py
so that DJANGO_SETTINGS_MODULE can be set to 'RecycleTech.settings_production'.
"""

# Ensure we import all production overrides from deploy module
from deploy.settings_production import *  # noqa: F401,F403 