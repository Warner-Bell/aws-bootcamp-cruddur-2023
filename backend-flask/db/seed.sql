-- this file was manually created
INSERT INTO public.users (display_name, email, handle, cognito_user_id)
VALUES
  ('Raymond Reddington', 'warner.bell21@gmail.com' , 'raymondreddington' ,'MOCK'),
  ('Elizabeth Keen', 'warner@cloudoptimizedlabs.com' , 'elizabethkeen' ,'MOCK'),
  ('Warner Bell', 'warner.bell@outlook.com' , 'warnerbell' ,'MOCK');

INSERT INTO public.activities (user_uuid, message, expires_at)
VALUES
  (
    (SELECT uuid from public.users WHERE users.handle = 'Red' LIMIT 1),
    'This was imported as seed data!',
    current_timestamp + interval '10 day'
  )