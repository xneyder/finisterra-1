#!/bin/bash

# Loop through each line of the input file
while IFS='|' read -r name code
do
cat << EOF

await prisma.providerGroup.upsert({
  where: { code: "${code}" },
  update: {},
  create: {
    code: "${code}",
    name: "${name}",
    description: "${name}",
    active: true,
    provider: {
      connect: {
        id: provider.id,
      },
    },
  },
});
EOF
done < input.txt

