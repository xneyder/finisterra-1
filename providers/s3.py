import os
from utils.hcl import HCL


class S3:
    def __init__(self, session, script_dir, provider_name, schema_data, region):
        self.session = session
        self.        self.transform_rules = {
            # "aws_route53_zone": {
            #     "hcl_transform_fields": {
            #         "force_destroy": {'source': None, 'target': False},
            #         "comment": {'source': "", 'target': ""},
            #     },
            # },
            # "aws_route53_record": {
            #     "hcl_drop_fields": {
            #         "multivalue_answer_routing_policy": False,
            #         "ttl": 0,
            #     },
            # },
        }
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def S3(self):
        self.hcl.prepare_folder(os.path.join("generated", "s3"))

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
