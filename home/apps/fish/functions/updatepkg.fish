function updatepkg
    pkgctl version upgrade
    makepkg --printsrcinfo > .SRCINFO
    rm *.tar.gz
    set -l pkg_ver (cat .SRCINFO | grep pkgver | string split -f2 '=' | string trim)
    set -l commit_prefix (git show -s --format='%s' | string split -r -m1 -f1 ' ')
    git add .SRCINFO PKGBUILD
    git commit -m "$commit_prefix $pkg_ver"
end
