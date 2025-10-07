import http from 'http';
import { exec } from 'child_process';

http
	.createServer((req, res) => {
		if (req.method === 'POST') {
			exec('/root/scripts/deploy.sh', (err, stdout, stderr) => {
				console.log(stdout, stderr);
			});
		}
		res.end('OK');
	})
	.listen(9000);
