DIGESTS=$(doctl registry repository lm $1 --format Digest,UpdatedAt | tail -n +2 | sort -rk2 | awk '{print $1}' | grep -v -E "$3" | tail -n +$(($2+1)))
for DIGEST in $DIGESTS; do
  doctl registry repository delete-manifest $1 $DIGEST --force
done
echo Manifest Digests removed: $DIGESTS

doctl registry garbage-collection start --include-untagged-manifests --force
