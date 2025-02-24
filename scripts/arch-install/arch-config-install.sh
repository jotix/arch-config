git clone --bare git@github.com:jotix/arch-config.git $HOME/.arch-config
                 
function config {
   /usr/bin/git --git-dir=$HOME/.arch-config/ --work-tree=$HOME $@
}

mkdir -p .config-backup

config checkout

if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;

config checkout

config config status.showUntrackedFiles no
