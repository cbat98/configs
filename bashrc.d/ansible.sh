# Ansible: prefer local microlise collections checkout, then installed collections.
_ansible_collections_repo="${HOME}/repos/ansible_collections"
if [[ -d "${_ansible_collections_repo}/microlise" ]]; then
	export ANSIBLE_COLLECTIONS_PATH="${_ansible_collections_repo}:${ANSIBLE_COLLECTIONS_PATH:-${HOME}/.ansible/collections:/usr/share/ansible/collections}"
fi
unset _ansible_collections_repo
