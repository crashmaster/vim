" This config file contains options related to the Vi compatibility

set cpoptions+=$        " Put a '$' at the end of the changed text

if exists("*SourceSiteConfig")
    call SourceSiteConfig(escape(expand('<sfile>:p'), '\'))
endif

