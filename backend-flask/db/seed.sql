-- this file was manually created
INSERT INTO public.users (display_name, email, handle, cognito_user_id)
VALUES
  ('Raymond Reddington', 'warner.bell21@gmail.com' , 'raymondreddington' ,'MOCK'),
  ('Elizabeth Keen', 'warner@cloudoptimizedlabs.com' , 'elizabethkeen' ,'MOCK'),
  ('Warner Bell', 'warner.bell@outlook.com' , 'warnerbell' ,'MOCK');

INSERT INTO public.activities (user_uuid, message, expires_at)
VALUES
  (
    (SELECT uuid from public.users WHERE users.handle = 'raymondreddington' LIMIT 1),
    'This was imported as seed data!',
    current_timestamp + interval '10 day'
  ),
  (
    (SELECT uuid from public.users WHERE users.handle = 'warnerbell' LIMIT 1),
    'I am the other!',
    current_timestamp + interval '10 day'
  );