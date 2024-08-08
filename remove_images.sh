DIGESTS=$(doctl registry repository lm $1 --format Digest,UpdatedAt,Tags | tail -n +2 | sort -rk2 | grep -v -E "$3" | awk '{print $1}' | tail -n +$(($2+1)))
for DIGEST in $DIGESTS; do
  doctl registry repository delete-manifest $1 $DIGEST --force
done
echo Manifest Digests removed: $DIGESTS

if [ "$4" == "true" ]; then
  echo "Skipping garbage collection"
  exit 0
fi
echo "Triggering garbage collection"
doctl registry garbage-collection start --include-untagged-manifests --force